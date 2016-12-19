#!/usr/bin/env python 
import psutil

for x in range(3):
    psutil.cpu_percent(interval=1, percpu=True)
    print x


for x in range(3):
    psutil.cpu_times_percent(interval=1, percpu=False)
    print x

a=psutil.cpu_count()
print a


e=psutil.cpu_count(logical=False)
print 'cpu count'
print e

i=psutil.cpu_stats()
print 'cpu stats'
print i

o=psutil.virtual_memory()
print 'virtual memory'
print o

u=psutil.swap_memory()
print 'swap memory'
print u

y=psutil.disk_partitions()
print 'disk partitions'
print y

q=psutil.disk_usage('/')
print 'disk usage'
print q

w=psutil.net_io_counters(pernic=True)
print 'interface io'
print w

#psutil.net_connections()

x=psutil.net_if_addrs()
print '#############################################'
print 'interface addresses'
print '#############################################'
print x

psutil.net_if_stats()

psutil.users()


