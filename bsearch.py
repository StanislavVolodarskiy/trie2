import bisect
import pickle


def make(seq):
    table = []
    for s in seq:
        n = len(s)
        if n >= len(table):
            table.extend([] for _ in range(n - len(table) + 1))
        table[n].append(s)
    for row in table:
        row.sort()
    return table


def prefix_len(table, s):
    for n in range(min(len(s) + 1, len(table)))[::-1]:
        row = table[n]
        s_n = s[:n]
        i = bisect.bisect_left(row, s_n)
        if i < len(row) and row[i] == s_n:
            return n
    return -1


def save(table, f):
    pickle.dump(table, f)


def load(f):
    return pickle.load(f)
