function cipherBytes = encrypt(plainBytes, keyBytes)
    % One-Time Pad encryption (byte-wise XOR).

    % Normalise inputs
    plainBytes = uint8(plainBytes(:)');
    keyBytes   = uint8(keyBytes(:)');

    if numel(plainBytes) ~= numel(keyBytes)
        error("otpEncrypt:LengthMismatch", ...
              "Plaintext and key must have same length.");
    end

    cipherBytes = bitxor(plainBytes, keyBytes);
end
