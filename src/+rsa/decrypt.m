function message = decrypt(cipherNum, d, n)
%DECRYPT RSA decryption for simple text-only input.
%   Takes the ciphertext integer, performs RSA, and rebuilds the original text.

    m = rsa.modExp(cipherNum, d, n);

    % Convert integer back into bytes (base-256)
    bytes = [];
    while m > 0
        b = mod(m, 256);
        bytes = [uint8(b), bytes];
        m = floor(m / 256);
    end

    message = char(bytes);
end
