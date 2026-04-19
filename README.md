# Agebraric-EC-Codes

### Helpers.sage
In "Helpers.sage2, you will find some helperfunctions which is used in some of the other sage files.

### SystematicEncoder.sage
In "SystematicEncoder.sage" you will find a simple implementation of a very systematic encoder. To encode a message yourself, you can modify the vector "message" and run the script.

### Precomputer.sage
In "Precomputer.sage" you can find functions for precomputing the lagrange basis and the polynomial G, as well as functions for saving the precomputed polynomials in the cashe. This is done to prepare the srcipt "Decoder.sage" for decoding a message in O(n^2) time. Do not modify this script, it is strictly there for running before "Decoder.sage" runs for the first time.


### Decoder.sage
The file "Decoder.sage" starts of by loading the precomputed polynomials before it goes on to either estimate the faliure- and error-rate of the code or just do one decoding. To run the script, choose one of the test runs by choosing either "test_run = 1" or "test_run = 2".

If you choose "test_run = 1", just modify the input of the function "estimate_error_rate" to your liking, and run the script

If you choose "test_run = 2", just write the codeword you would like to decode (using alpha as the field generator).