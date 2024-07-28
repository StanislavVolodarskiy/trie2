import sys

import trie2

with open(sys.argv[1], 'rb') as f:
    trie = trie2.load(f)

for line in map(str.strip, sys.stdin):
    k = trie2.prefix_len(trie, line)
    prefix = line[:k] if k >= 0 else 'N/A'
    print(line, k, prefix)
