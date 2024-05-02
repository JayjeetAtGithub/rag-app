import numpy as np

d = 5                           # dimension
nb = 10                      # database size
nq = 5                       # nb of queries
np.random.seed(1234)             # make reproducible
xb = np.random.random((nb, d)).astype('float32')
xb[:, 0] += np.arange(nb) / 1000.
xq = np.random.random((nq, d)).astype('float32')
xq[:, 0] += np.arange(nq) / 1000.


print("Dataset: ")
print(xb)

print("Queries: ")
print(xq)

import faiss                   # make faiss available
index = faiss.IndexFlatL2(d)   # build the index
index.add(xb)                  # add vectors to the index

print("Searches: ")

k = 1                          # we want to see 4 nearest neighbors
D, I = index.search(xq, k)
print(I)
print(D)