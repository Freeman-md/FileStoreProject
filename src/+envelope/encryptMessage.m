function out = encryptMessage(plaintext, publicKey, roundKeys)

    if isstring(plaintext)
        plaintext = char(plaintext);
    end
    if ischar(plaintext)
        plaintext = uint8(plaintext);
    end

    % RSA key parts
    e = publicKey(1);
    n = publicKey(2);

    % *** ONE BYTE AES KEY (demo constraint)
    aesKey = uint8(randi([0 255], 1, 1));
    aesKeyChar = char(aesKey);

    % AES encrypt using roundKeys only (your AES ignores aesKey)
    [ciphertext, iv] = aes.encryptCBCMode(plaintext, roundKeys);

    % RSA wrap of 1-byte key
    encryptedKey = rsa.encrypt(aesKeyChar, e, n);

    out = struct( ...
        'encryptedKey', encryptedKey, ...
        'ciphertext', ciphertext, ...
        'iv', iv ...
    );
end
