import sys

import bsearch

table = bsearch.make(s.strip() for s in sys.stdin)
with open(sys.argv[1], 'wb') as f:
    bsearch.save(table, f)

