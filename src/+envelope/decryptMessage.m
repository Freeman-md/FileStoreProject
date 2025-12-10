function plaintext = decryptMessage(env, privateKey, roundKeys)

    d = privateKey(1);
    n = privateKey(2);

    aesKeyChar = rsa.decrypt(env.encryptedKey, d, n);
    aesKey = uint8(aesKeyChar);   % 1 byte

    plaintext = aes.decryptCBCMode(env.ciphertext, env.iv, roundKeys);
end
