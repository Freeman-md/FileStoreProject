function plaintext = decryptMessage(encryptedStruct, privateKey, roundKeys)
% envelope.decryptMessage

% Envelope Decryption:
% 1. RSA decrypt AES key
% 2. AES-CBC decrypt ciphertext
% 3. Return plaintext as uint8

    % Extract struct fields
    encryptedKey = encryptedStruct.encryptedKey;
    ciphertext   = encryptedStruct.ciphertext;
    iv           = encryptedStruct.iv;

    % --- STEP 1: RSA DECRYPT THE AES KEY ---
    aesKey = rsa.decrypt(encryptedKey, privateKey);

    % --- STEP 2: AES-CBC DECRYPTION ---
    plaintext = aes.decryptCBCMode(ciphertext, aesKey, iv, roundKeys);

    % Always output uint8
    if ~isa(plaintext, 'uint8')
        plaintext = uint8(plaintext);
    end
end
