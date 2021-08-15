# Overview

- 1. List parents of each node
- 2. Search heviest path in tree (including not binarry tree)
- a. LCA: lowest ancestor in tree(not binary tree)

## 1. List parents of each node

- traverse from top to bottom to create parentsOf list.

## 2. Search heaviest path in tree

- Pre process
  - create adj list

1. find leaf which is included in heviest path, from top to all node.
2. find heviest path from leaf to all node.

## a. LCA

- 1. pre process
  - create adj list which is uni-directional
- 2. find LCA using recursive way

## LICENSE

MIT
