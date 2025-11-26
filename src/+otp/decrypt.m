function plainBytes = decrypt(cipherBytes, keyBytes)
    % One-Time Pad decryption (same XOR operation).

    cipherBytes = uint8(cipherBytes(:)');
    keyBytes    = uint8(keyBytes(:)');

    if numel(cipherBytes) ~= numel(keyBytes)
        error("otpDecrypt:LengthMismatch", ...
              "Ciphertext and key must have same length.");
    end

    plainBytes = bitxor(cipherBytes, keyBytes);
end
