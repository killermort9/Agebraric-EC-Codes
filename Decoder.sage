load("Helpers.sage")
load("Precomputer.sage")
import random

if "precomp" not in globals():
    precomp = load_precomp()



def decoder(r, k, print_=False):
    Rx = sum((y*Li for y, Li in zip(r, L)), R.zero())

    M = matrix(R, [[G, 0 ],[-Rx, 1 ]])

    while not kReduced(M, k):
        qx, rx = (M[0 ,0 ]).quo_rem(M[1 ,0 ])
        M = matrix([[0 ,1 ],[1 ,-qx]])*M

    f_guess, remainder = return_f_and_remainder(M, k)

    if remainder != 0:
        c_guess = None
    else:
        c_guess = vector(F, [f_guess(xi) for xi in x])
    
    if print_:
        print(f"The decoded polynomial is {f_guess} and the corresponding codeword is {c_guess}")
    return c_guess


def load_precomp_parameters():
    F = precomp["F"]
    alpha = precomp["alpha"]
    R = precomp["R"]
    X = precomp["X"]
    x = precomp["x"]
    G = precomp["G"]
    L = precomp["L"]
    return F, alpha, R, X, x, G, L


@parallel(ncpus=8)
def test_run(k, c, P):
    e = vector(F, random.choices(list(F), weights=[1 -P]+[P/255 ]*255 , k=255 ))
    r = c + e
    decoded_message = decoder(r, k)
    if c == decoded_message:
        return True
    elif decoded_message == None:
        return "Unable"
    else:
        return "Wrong codeword"

        
def estimate_error_rate(k, P, Iterations):
    F, alpha, R, X, x, G, L = load_precomp_parameters()

    f = X
    c = vector(F, [f(i) for i in x])
    RR = RealField(1000 )
    
    decoding_successes = 0
    decoding_faliures = 0
    decoding_errors = 0

    import time
    t_start = time.time()
    inputs = [(k,c,P) for _ in range(Iterations)]
    for input_data, result in test_run(inputs):
        match result:
            case True:
                decoding_successes += 1
            case "Unable":
                decoding_faliures += 1
            case "Wrong codeword":
                decoding_errors += 1
                decoding_faliures += 1

    print(f"The time used was {(time.time()-t_start)/60} minutes")
    print(f"The number of iterations caculated was: {Iterations}")
    print(f"The number of decoding successes was: {decoding_successes}")
    print(f"The number of decoding faliures was: {decoding_faliures}")
    print(f"The number of decoding errors was: {decoding_errors}")
    return None


if __name__ == "__main__":
    '''
    Choose which test run you want to do:
    1 - estimate the error rate - modify the input parameters for the function as you like
    2 - Decode one codeword - write the codeword you would like to decode (using alpha as the field generator)
    '''
    test_run = 2 # Either 1 or 2

    if test_run == 1:
        estimate_error_rate(k=251, P=0.001, Iterations=100000)
    elif test_run == 2:
        F, alpha, R, X, x, G, L = load_precomp_parameters()

        c = vector(F, [0 for i in range(255)])

        decoder(r=c, k=251, print_=True)
    else:
        print("Invalid value of test_run")
