function cipherNum = encrypt(message, e, n)
% ENCRYPT RSA encryption for simple text-only input.
%   Converts the message into a big integer, applies RSA, and returns the
%   ciphertext number

    if isstring(message)
        message = char(message);
    end

    bytes = uint8(message);
    m = 0;

    % Build integer from bytes (base-256)
    for i = 1:length(bytes)
        m = m * 256 + double(bytes(i));
    end

    if m >= n
        error('Message is too large for the chosen RSA modulus.');
    end

    cipherNum = rsa.modExp(m, e, n);
end
