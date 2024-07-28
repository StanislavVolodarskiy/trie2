import sys

import trie2

trie = trie2.make(s.strip() for s in sys.stdin)
with open(sys.argv[1], 'wb') as f:
    trie2.save(trie, f)
