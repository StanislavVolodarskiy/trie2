import itertools
import random
import sys

s = int(sys.argv[1])
n = int(sys.argv[2])
p = float(sys.argv[3])
b = int(sys.argv[4])

random.seed(s)
while b > 0:
    for c in itertools.product('0123456789', repeat=n):
        if b <= 0:
            break
        if random.random() < p:
            print(''.join(c))
            b -= len(c)
    n += 1
