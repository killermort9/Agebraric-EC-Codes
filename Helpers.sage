def km1deg(liste, k):
    try:
        return max(liste[0].degree(), liste[1].degree()+k-1)
    except:
        raise TypeError("One of the entries in the list does not have a degree")


def kReduced(M, k):
    if M[0,0].degree() >= M[0,1].degree() +k-1 and M[1,0].degree() < M[1,1].degree() + k-1:
        return True
    return False

def lagrange_basis(x, R, k=None):
    if k == None:
        k = len(x)
    X = R.gen()
    basis = []
    for i, xi in enumerate(x[:k]):
        Li = R(1)
        for j, xj in enumerate(x[:k]):
            if i != j:
                Li *= R((X - R(xj)) / (R(xi) - R(xj)))
        basis.append(Li)
    return basis

def return_f_and_remainder(P, k):
    if km1deg(P[0],k) < km1deg(P[1],k):
        f, remainder = (-P[0,0]).quo_rem(P[0,1])
    else:
        f, remainder = (-P[1,0]).quo_rem(P[1,1])
    return f, remainder