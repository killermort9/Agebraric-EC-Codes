load("Helpers.sage")

def systematic_encoder(n, x, message, R):
    '''
    Parameters
    -----
    n : int
        len of codewords
    x : sage.vector
        Vector that is evaluated by the basis
    message : sage.vector
        The message you want encoded
    R : sage.PolynomialRing
        The polynomial ring the RS code is defined over
    '''
    codeword = message*very_systematic_generator_matrix(n=n, k=len(message), x=x, R=R)
    return codeword

def very_systematic_generator_matrix(n, k, x, R):
    '''
    n : int
        len of codewords
    k : int
        The length of any message
    x : sage.vector
        Vector that is evaluated by the basis
    R : sage.PolynomialRing
        The polynomial ring the RS code is defined over
    '''
    L = lagrange_basis(x, R, k)
    M = matrix([[Li(xi) for xi in x] for Li in L])
    return M
    
    
    return systematic_encoder(n=n, x=x, message=message, R=R)
if __name__ == "__main__":
    q = 256
    n = 255
    F = GF(q, name="alpha")
    alpha = F.gen()
    R = PolynomialRing(F, "X")
    X = R.gen()

    message = vector(F, [1,1,1,0,0,0])

    k = len(message)
    x = vector(F, [alpha**(i-1) for i in range(1, n + 1)])

    print(f"The encoded version of the message {message} is: {systematic_encoder(n, x, message, R)}")