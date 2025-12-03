function plainText = decrypt(cipherText, key)
%OTP.DECRYPT Text-based One-Time Pad decryption.

    cipherBytes = uint8(cipherText);
    plainBytes  = bitxor(cipherBytes, key);
    plainText   = char(plainBytes);
end
