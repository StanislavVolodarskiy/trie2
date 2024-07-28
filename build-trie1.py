import sys

import trie1

trie = trie1.make(s.strip() for s in sys.stdin)
with open(sys.argv[1], 'wb') as f:
    trie1.save(trie, f)
