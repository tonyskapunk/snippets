#!/usr/bin/env python
"""Translate the seconds after boot from dmesg to a timestamp."""

import re
import sys
import subprocess
from datetime import datetime, timedelta

DMESG = '/bin/dmesg'
UPTIME = '/proc/uptime'
UNIXTIME = datetime(1970, 1, 1)

try:
    OUT, ERR = subprocess.Popen([DMESG],
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE).communicate()
except OSError:
    sys.exit('Error when issuing dmesg.')
DMESG_OUTPUT = OUT.split('\n')

with open(UPTIME, 'r') as f:
    UPTIME = f.read()
    NOW = datetime.now()
f.close()

SECS_SINCE_BOOT = float(UPTIME.split(" ")[0])
BOOT_TIME = NOW - timedelta(seconds=SECS_SINCE_BOOT)
print "Booted: %s\n" % BOOT_TIME

for line in DMESG_OUTPUT:
    matched = re.match(r'^\s*[\s*(\d*\.\d*)].*', line)
    if matched:
        if len(matched.groups(1)):
            ts_sec = matched.groups(1)[0]
            td = timedelta(seconds=float(ts_sec))
            ts = BOOT_TIME + td
            print "[%s] - %s" % (ts, line)
        else:
            print line
    else:
        print line        
