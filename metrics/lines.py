import pathlib
import re
import csv

def main():
    data = []
    p = pathlib.Path('../benchmarks')
    for mark in p.iterdir():
        print(mark)
        if not mark.is_dir():
            continue
        for f in mark.iterdir():
            if re.match(r'.*[.](reg|stack|opt)[.](ll|s)', str(f)):
                data.append((f, count_inst(f)))
    with open('lines.raw.csv', 'w', newline='') as f:
        w  = csv.writer(f)
        w.writerows(data)


def count_inst(path):
    count = 0
    with open(path, 'r') as f:
        for line in f:
            if re.match(r'\t[^.].*', line):
                count += 1
    return count


main()
