#!/usr/bin/python
import sys 
import os

def ustrip(s):
    res = ''
    for c in s:
        if c == ' ' or c == '\t':
            continue 
        res += c 
    return res

class important_info:
    def __init__(self, entryline = -1, startupline = -1):
        self._entryline = entryline 
        self._startupline = startupline


def parse_menuentry(path):
    content = ''
    with open(path) as f:
        content += f.read()
    contentlist = content.split('\n')
    infolist = []
    for i in range(len(contentlist)): 
        if 'menuentry' in contentlist[i] and 'class' in contentlist[i]: 
            # print contentlist[i]
            infolist.append(important_info(i))
        if 'linux' in contentlist[i] and contentlist[i].split()[0] == 'linux':
            # print contentlist[i]
            infolist[-1]._startupline = i 
    return contentlist, infolist

def append_entry(contentlist, infolist, idx, baud = 115200):
    print '[+] Editing entry {0}'.format(contentlist[infolist[idx]._entryline].split()[1])
    if 'kgdb' in contentlist[infolist[idx]._startupline]:
        print '[!] Kgdb have been enabled yet.'
        return 
    else: 
        contentlist[infolist[idx]._startupline] += ' quiet kgdbwait kgdb8250=io,03f8,ttyS0,{0},4 kgdboc=ttyS0,{0} kgdbcon nokaslr'.format(baud)
    # print contentlist[infolist[idx]._startupline]

def go(path, output = None):
    contentlist, infolist = parse_menuentry(path)
    append_entry(contentlist, infolist, 0)
    res = ''
    for l in contentlist:
        if l == '':
            continue
        res += l + '\n'
    if output == None:
        output = path 
    with open(output, 'w') as f:
        f.write(res)

if __name__ == '__main__':
    os.system('cp /boot/grub/grub.cfg /boot/grub/grub.cfg.bak')
    go('/boot/grub/grub.cfg')
