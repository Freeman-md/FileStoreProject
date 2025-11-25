function cipherBytes = encrypt(plainBytes, keyBytes)
    % OTP Encryption using XOR on byte arrays

    % plainBytes  : uint8 row vector (plaintext data)
    % keyBytes    : uint8 row vector (same length as plainBytes)
    % cipherBytes : uint8 row vector (encrypted data)

    if ~isa(plainBytes, 'uint8') || ~isa(keyBytes, 'uint8')
        error('otpEncrypt:InputsMustBeUint8', ...
            'plainBytes and keyBytes must be uint8 arrays.');
    end

    if numel(plainBytes) ~= numel(keyBytes)
        error('otpEncrypt:LengthMismatch', ...
            'Key length must match plaintext length for OTP.');
    end

    
    cipherBytes = bitxor(plainBytes, keyBytes);
end