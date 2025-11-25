function plainBytes = decrypt(cipherBytes, keyBytes)
    % OTP decryption using XOR on byte arrays

    % cipherBytes : uint8 row vector (encrypted data)
    % cipherBytes : uint8 row vector (encrypted data)
    % cipherBytes : uint8 row vector (encrypted data)

    if ~isa(cipherBytes, 'uint8') || ~isa(keyBytes, 'uint8')
        error('otpDecrypt:InputsMustBeUint8', ...
            'cipherBytes and keyBytes must be uint8 arrays.');
    end

    if numel(cipherBytes) ~= numel(keyBytes)
        error('otpDecrypt:LengthMismatch', ...
            'Key length must match ciphertext length for OTP.');
    end


    plainBytes = bitxor(cipherBytes, keyBytes);
end