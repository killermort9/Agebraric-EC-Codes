load("Helpers.sage")
import os

q = 256
n = 255
CACHE_FILE = f"precomp_q{q}_n{n}.sobj"

def load_precomp(q=q, n=n):
    F = GF(q, name="alpha")
    alpha = F.gen()
    R = PolynomialRing(F, "X")
    X = R.gen()

    x = vector(F, [alpha**(i-1) for i in range(1, n + 1)])
    cache_file = f"precomp_q{q}_n{n}.sobj"

    if os.path.exists(cache_file):
        precomp = load(cache_file)
    else:
        G = prod([i - X for i in x])
        L = lagrange_basis(x, R)
        precomp = {
            "q": q,
            "n": n,
            "x": x,
            "G": G,
            "L": L,
        }
        save(precomp, cache_file)

    # Runtime objects are derived from q/n and are not loaded from cache.
    precomp["F"] = F
    precomp["R"] = R
    precomp["alpha"] = alpha
    precomp["X"] = X
    return precomp

precomp = load_precomp(q=q, n=n)
F = precomp["F"]
alpha = precomp["alpha"]
R = precomp["R"]
X = precomp["X"]
x = precomp["x"]
G = precomp["G"]
L = precomp["L"]

