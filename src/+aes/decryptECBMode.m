function plaintextBytes = decryptECBMode(ciphertextBytes, roundKeys)
%AES.DECRYPTECBMODE Decrypt AES-128 ECB ciphertext of arbitrary length.

    if ~isa(ciphertextBytes, "uint8")
        error("decryptECBMode:InvalidInput", ...
              "Ciphertext must be a uint8 array.");
    end

    ciphertextBytes = ciphertextBytes(:).';  % ensure row vector
    blockSize = 16;

    if mod(numel(ciphertextBytes), blockSize) ~= 0
        error("decryptECBMode:InvalidLength", ...
              "Ciphertext length must be a multiple of 16 bytes.");
    end

    numBlocks = numel(ciphertextBytes) / blockSize;
    decrypted = zeros(1, numBlocks * blockSize, "uint8");

    for blockIndex = 1:numBlocks
        startIdx = (blockIndex - 1) * blockSize + 1;
        block = ciphertextBytes(startIdx:startIdx + blockSize - 1);

        decrypted(startIdx:startIdx + blockSize - 1) = ...
            aes.decryptBlock(block, roundKeys);
    end

    % Remove PKCS#7 Padding
    padAmount = decrypted(end);
    if padAmount < 1 || padAmount > blockSize
        error("decryptECBMode:BadPadding", ...
              "Invalid padding value.");
    end

    plaintextBytes = decrypted(1:end - padAmount);
end
