import csv
import re
import pathlib

#------------------------------------------------------------
def processTimes():
    data = []
    with open('time.bash.csv', 'r') as f:
        r = csv.reader(f)
        for line in r:
            name = line[0].strip()
            time = line[1].strip()
            t = time.split()[1]
            name, options = parseFilename(name)
            secs = parseTime(t)
            data.append((name, options, secs))

    with open('time.py.csv', 'w+', newline='') as f:
        w = csv.writer(f)
        w.writerows([('Benchmark', 'Compilation', 'Seconds')] + data)


def parseTime(t):
    m = re.match(r'(.*)m(.*)s', t)
    if m:
        return float(m.group(1))*60 + float(m.group(2))
    else:
        print(f'ERROR {t}')


def parseFilename(n):
    m = re.match(r'[.][.]/benchmarks/(.*)/[^.]*[.](.*)[.]out', n)
    return m.groups()


#------------------------------------------------------------
def processLines():
    data = []
    with open('lines.raw.csv', 'r') as f:
        r = csv.reader(f)
        for line in r:
            name = line[0].strip()
            count = line[1].strip()
            name, options, lang = parseFilenameCount(name)
            data.append((name, options, lang, count))
    with open('lines.final.csv', 'w+', newline='') as f:
        w = csv.writer(f)
        w.writerows([('Benchmark', 'Compilation', 'Format', 'Lines')] + data)


def parseFilenameCount(n):
    m = re.match(r'[.][.]/benchmarks/(.*)/[^.]*[.](.*)[.](.*)', n)
    return m.groups()


#------------------------------------------------------------
def makeChartsDir():
    p = pathlib.Path("charts/")
    p.mkdir(parents=True, exist_ok=True)


#------------------------------------------------------------

makeChartsDir()
processTimes()
processLines()
