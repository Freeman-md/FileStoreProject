function result = modExp(base, exponent, modulus)
%MODEXP Fast modular exponentiation (binary exponentiation)
%   Computes (base^exponent) mod modulus efficiently.

    base = mod(base, modulus);
    result = 1;

    while exponent > 0
        if bitand(exponent, 1) == 1
            result = mod(result * base, modulus);
        end
        base = mod(base * base, modulus);
        exponent = bitshift(exponent, -1);
    end
end
