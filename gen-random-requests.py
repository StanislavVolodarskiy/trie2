import itertools
import random
import sys

s = int(sys.argv[1])
n1 = int(sys.argv[2])
n2 = int(sys.argv[3])
k = int(sys.argv[4])

random.seed(s)
for _ in range(k):
    n = random.randrange(n1, n2)
    print(''.join(random.choices('0123456789', k=n)))
