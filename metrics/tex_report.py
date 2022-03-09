import csv


tex = r"""
\newpage
\subsection{|BENCHMARK|}
    \begin{figure}[h]
	    \centering
		\input{charts/|BENCHMARK_F|}
	\end{figure}
    \input{charts/|BENCHMARK_F|Table}
"""

def cleanup_table(benchmark):
    table_path = f'charts/{benchmark}Table.tex'
    with open(table_path, 'r') as in_file:
        table_tex = in_file.read()

    with open(table_path, 'w') as out_file:
        out_file.write(table_tex.replace(
            'rrrrrrr',
            'p{0.2\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}p{0.1\\textwidth}'
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
            print(tex.replace('|BENCHMARK_F|', benchmark).replace('|BENCHMARK|', tex_escape(benchmark)), file=out_file)

main()
