import csv


def cleanup_table(benchmark):
    table_path = f'charts/{benchmark}Table.tex'
    with open(table_path, 'r') as in_file:
        table_tex = in_file.read()

    with open(table_path, 'w') as out_file:
        out_file.write(table_tex.replace(
            'rrrrrrr',
            'p{0.2\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}'
        ).replace(
            '\\end{table}',
            f'\caption{{{tex_escape(benchmark)} runtime (in seconds) summary statistic based on 10 runs each}}\n\\end{{table}}'
        ).replace(
            '[ht]', '[h!]'
        ))


def cleanup_inst_table(benchmark):
    table_path = f'charts/{benchmark}InstTable.tex'
    with open(table_path, 'r') as in_file:
        table_tex = in_file.read()

    with open(table_path, 'w') as out_file:
        out_file.write(table_tex.replace(
            'rrr',
            'p{0.2\\textwidth}p{0.2\\textwidth}p{0.2\\textwidth}'
        ).replace(
            '\\end{table}',
            f'\caption{{{tex_escape(benchmark)} instruction counts for generated code excluding labels}}\n\\end{{table}}'
        ).replace(
            '[ht]', '[h!]'
        ))


def tex_escape(s: str):
    return s.replace('_', "\\_")


def main():
    with open('time.py.csv', 'r') as in_file:
        reader = csv.reader(in_file)
        benchmarks = sorted(list(set([line[0] for line in reader][1:])))

    with open('charts.tex', 'w') as out_file:
        for benchmark in benchmarks:
            cleanup_table(benchmark)
            cleanup_inst_table(benchmark)
            print(f"""
\\newpage
\\subsection{{{tex_escape(benchmark)}}}
    \\input{{charts/{benchmark}InstTable}}
    \\begin{{figure}}[h]
	    \\centering
		\\input{{charts/{benchmark}}}
        \\caption{{{tex_escape(benchmark)} runtimes measured on 32bit ARM Raspberry Pis}}
	\\end{{figure}}
    \\input{{charts/{benchmark}Table}}
"""
                , file=out_file)


main()
