import pickle


def make(seq):
    trie = {}
    for s in seq:
        node = trie
        for c in s:
            # move to child
            node = node.setdefault(c, {})
        # mark last node as end of string
        node[''] = None
    return trie


def prefix_len(trie, s):
    node = trie
    j = -1
    for i, c in enumerate(s):
        # node is marked as end of string
        if '' in node:
            j = i

        # move to child if present
        node = node.get(c)
        if node is None:
            break
    else:
        # node is marked as end of string
        if '' in node:
            j = len(s)
    return j


def save(trie, f):
    pickle.dump(trie, f)


def load(f):
    return pickle.load(f)
