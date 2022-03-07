import csv


tex = r"""
\newpage
\subsection{|BENCHMARK|}
    \begin{figure}[h]
	    \centering
		\input{|BENCHMARK_F|}
	\end{figure}
"""

def tex_escape(s: str):
    return s.replace('_', "\\_")

def main():
    with open('time.py.csv', 'r') as in_file:
        reader = csv.reader(in_file)
        benchmarks = sorted(list(set([line[0] for line in reader][1:])))

    with open('charts.tex', 'w') as out_file:
        for benchmark in benchmarks:
            print(tex.replace('|BENCHMARK_F|', benchmark).replace('|BENCHMARK|', tex_escape(benchmark)), file=out_file)

main()
