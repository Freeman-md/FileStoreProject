function [n, e, d] = generateKeys()
%GENERATEKEYS Generate simple RSA keypair for text-only encryption.
%   Uses small demo primes for predictable behaviour

    % Pick two small primes (sufficient for demonstration)
    p = 61;
    q = 53;

    n = p * q;
    phi = (p - 1) * (q - 1);

    % Public exponent
    e = 17;  
    % Make sure e and phi are coprime
    if gcd(e, phi) ~= 1
        error('e and phi(n) must be coprime.');
    end

    % Private exponent
    d = rsa.modInverse(e, phi);

    if isempty(d)
        error('Could not compute modular inverse for RSA key generation.');
    end
end
