import sys

import trie1

with open(sys.argv[1], 'rb') as f:
    trie = trie1.load(f)

for line in map(str.strip, sys.stdin):
    k = trie1.prefix_len(trie, line)
    prefix = line[:k] if k >= 0 else 'N/A'
    print(line, k, prefix)
