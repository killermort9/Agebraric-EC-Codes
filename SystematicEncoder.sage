load("Helpers.sage")

def define_standard_parameters():
    q = 256
    n = 255
    F = GF(q, name="alpha")
    alpha = F.gen()
    R = PolynomialRing(F, "X")
    X = R.gen()
    x = vector(F, [alpha**(i-1) for i in range(1, n + 1)])
    return q, n, F, alpha, R, X, x

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
    '''
    Modify the message to a lenth of less than 255 using "alpha" as the generator for the field. then run the script
    '''
    q, n, F, alpha, R, X, x = define_standard_parameters()

    message = vector(F, [1,1,1,0,0,0]) # The length cannot be longer than 255
    k = len(message)

    print(f"The encoded version of the message {message} is: {systematic_encoder(n, x, message, R)}")