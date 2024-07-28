import sys

import bsearch

with open(sys.argv[1], 'rb') as f:
    table = bsearch.load(f)

for line in map(str.strip, sys.stdin):
    k = bsearch.prefix_len(table, line)
    prefix = line[:k] if k >= 0 else 'N/A'
    print(line, k, prefix)
