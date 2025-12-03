function [cipherText, key] = encrypt(plainText)
%OTP.ENCRYPT Text-based One-Time Pad encryption.

    plainBytes = uint8(plainText);
    key        = randi([0, 255], 1, numel(plainBytes), 'uint8');

    cipherBytes = bitxor(plainBytes, key);
    cipherText  = char(cipherBytes);
end
