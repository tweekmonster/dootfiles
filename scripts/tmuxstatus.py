#!/usr/bin/env python
import os
import time
import threading

import psutil

from collections import defaultdict
from Queue import deque

output_file = '/dev/shm/tmuxstatus'
pid_file = '/tmp/tmuxstatus.pid'

stop = threading.Event()
cpulock = threading.RLock()
netlock = threading.RLock()

net = {}
net_hist_max = 10
net_hist = defaultdict(lambda: deque(maxlen=net_hist_max))
cpu = []


class ColorTextRun(object):
    def __init__(self, *items):
        self.items = list(items)

    def __len__(self):
        return sum(map(len, self.items))

    def __str__(self):
        return str(''.join(map(str, self.items)))

    def __add__(self, other):
        self.items.append(other)
        return self

    def __radd__(self, other):
        self.items.insert(0, other)
        return self

    def encode(self, *args, **kwargs):
        return str(self).encode(*args, **kwargs)

    def decode(self, *args, **kwargs):
        return str(self).decode(*args, **kwargs)


class ColorText(object):
    def __init__(self, text, fg=None, bg=None, flags=0, rgb=False):
        self.text = text
        self.fg = fg
        self.bg = bg
        self.flags = flags
        self.ctype = 2 if rgb else 5

    def __len__(self):
        return len(self.text)

    def __str__(self):
        # params = [self.flags]
        params = []
        if self.fg:
            params.append('fg=colour%d' % self.fg)
            # params.extend([38, self.ctype, self.fg])
        if self.bg:
            params.append('bg=colour%d' % self.bg)
            # params.extend([48, self.ctype, self.bg])

        return u'#[%s]%s' % (','.join(map(str, params)), self.text)

    def __add__(self, other):
        return ColorTextRun(self, other)

    def __radd__(self, other):
        return ColorTextRun(other, self)

    def encode(self, *args, **kwargs):
        return str(self).encode(*args, **kwargs)

    def decode(self, *args, **kwargs):
        return str(self).decode(*args, **kwargs)


bars = [unichr(0x2581)]
for c in range(0x2581, 0x2589):
    bars.append(unichr(c))


def interval_generator(sleep_interval):
    while not stop.is_set():
        s = time.time()
        yield None
        n = time.time()
        time.sleep(max(0, sleep_interval - (n - s)))


def net_monitor():
    last_stat = psutil.net_io_counters(True)

    for _ in interval_generator(1):
        stat = psutil.net_io_counters(True)
        with netlock:
            for k, v in stat.items():
                if k == 'lo':
                    continue

                delta = (
                    v.bytes_recv - last_stat[k].bytes_recv,
                    v.bytes_sent - last_stat[k].bytes_sent,
                )
                if not len(net_hist[k]):
                    for _ in range(net_hist_max):
                        net_hist[k].append((0, 0))
                net_hist[k].append(delta)
                if len(filter(lambda x: sum(x) > 1024, net_hist[k])):
                    net[k] = delta
                else:
                    net.pop(k, None)
        last_stat = stat


def cpu_monitor():
    global cpu
    for _ in interval_generator(0.1):
        with cpulock:
            cpu = psutil.cpu_percent(interval=0, percpu=True)


def format_bytes(b):
    unit = ''
    for u in ['b', 'K', 'M', 'G', 'T', 'P']:
        if abs(b) < 1024:
            unit = u
            break
        b /= 1024
    s = '%3.1f' % b
    if s.endswith('.0'):
        s = s[:-2]
    return '%s%s' % (s, unit)


def bar_char(c, t, na=240, a=48):
    p = int((c / t) * (len(bars) - 1))
    return ColorText(bars[p], a if p else na)


def main():
    threads = []
    t = threading.Thread(target=net_monitor)
    t.daemon = True
    t.start()
    threads.append(t)

    t = threading.Thread(target=cpu_monitor)
    t.daemon = True
    t.start()
    threads.append(t)

    try:
        cpu_count = psutil.cpu_count()

        for _ in interval_generator(2):
            line = ColorText(u'\u276e\u00b7\u00b7\u276f ', 238)

            with netlock:
                for k, v in net.items():
                    rx_hist = ''
                    tx_hist = ''
                    rx_total = max(524288, max([x[0] for x in net_hist[k]]))
                    tx_total = max(524288, max([x[1] for x in net_hist[k]]))
                    for rx, tx in net_hist[k]:
                        rx_hist += bar_char(rx, rx_total)
                        tx_hist += bar_char(tx, tx_total, a=166)
                    line += ColorText('%s: ' % k, 243)
                    line += rx_hist + ' '
                    line += ColorText(u'%6s\u25BC ' % format_bytes(v[0]), 48)
                    line += tx_hist + ' '
                    line += ColorText(u'%6s\u25B2 ' % format_bytes(v[1]), 166)
            line += '  '

            loads = []
            c = None
            for l in os.getloadavg():
                if l < 0.5:
                    c = 240
                elif l > cpu_count - 0.25:
                    c = 160
                elif l > cpu_count - 0.5:
                    c = 166
                elif l >= 1:
                    c = 46
                loads.append(ColorText('%0.02f' % l, c))
            line += ', '.join(map(str, loads))
            line += ' '

            with cpulock:
                for c in cpu:
                    line += bar_char(c, 100)

            line += ' '

            with open(output_file, 'wb') as fp:
                fp.write(line.encode('utf8'))
    except KeyboardInterrupt:
        stop.set()

    for t in threads:
        t.join()


if __name__ == "__main__":
    if os.path.exists(pid_file):
        with open(output_file, 'wb') as fp:
            print(fp.read())
        sys.exit(0)
    pid = os.fork()
    if pid == 0:
        main()
        os.remove(pid_file)
    else:
        with open(pid_file, 'wb') as fp:
            fp.write(str(pid))
