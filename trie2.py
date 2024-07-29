import array
import pickle


ARRAY_TYPE = 'Q'
ABSENT = 1 << (array.array(ARRAY_TYPE).itemsize * 8) - 1
EMPTY = (ABSENT, ) * 10


def make(seq):
    trie = array.array(ARRAY_TYPE, [0] * 2)

    for s in seq:
        # trie root node
        p = 0
        for i in map(int, s):
            # this is a leaf (no subtree)
            if trie[p] < 2:
                # allocate new node
                trie[p] |= len(trie)
                trie.extend(EMPTY)

            # move to ith child
            p = (trie[p] & ~1) + i

            # mark child present
            if trie[p] == ABSENT:
                trie[p] = 0

        # mark last node as end of string
        trie[p] |= 1

    return trie


def prefix_len(trie, s):
    p = 0
    j = -1
    for k, i in enumerate(map(int, s)):
        # node is marked as end of string
        if trie[p] & 1 != 0:
            j = k

        # this is a leaf (no subtree)
        if trie[p] < 2:
            break

        # move to child
        p = (trie[p] & ~1) + i

        # if child is absent
        if trie[p] == ABSENT:
            break
    else:
        # node is marked as end of string
        if trie[p] & 1 != 0:
            j = len(s)
    return j


def save(trie, f):
    pickle.dump(trie, f)


def load(f):
    return pickle.load(f)
