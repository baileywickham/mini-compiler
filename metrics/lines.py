import pathlib
import re

def main():
    p = pathlib.Path('../benchmarks')
    for mark in p.iterdir():
        print(mark)
        if not mark.is_dir():
            continue
        for f in mark.iterdir():
            print(str(f))
            if re.match(r'll', str(f)):
                print(f)






main()