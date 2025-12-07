function plaintextBytes = decryptCBCMode(ciphertextBytes, ivBytes, roundKeys)
%AES.DECRYPTCBCMODE AES-128 CBC decryption for arbitrary-length ciphertext.
%
%   plaintextBytes = aes.decryptCBCMode(ciphertextBytes, ivBytes, roundKeys)

    % Ensure uint8
    if ~isa(ciphertextBytes, "uint8") || ~isa(ivBytes, "uint8")
        error("decryptCBCMode:InvalidInput", ...
              "Ciphertext and IV must be uint8.");
    end

    ciphertextBytes = ciphertextBytes(:).';   % row vector
    ivBytes = ivBytes(:).';                   % row vector
    blockSize = 16;

    if numel(ivBytes) ~= blockSize
        error("decryptCBCMode:BadIV", ...
              "IV must be 16 bytes for AES-128.");
    end

    if mod(numel(ciphertextBytes), blockSize) ~= 0
        error("decryptCBCMode:InvalidCipherLength", ...
              "Ciphertext length must be a multiple of 16 bytes.");
    end

    numBlocks = numel(ciphertextBytes) / blockSize;
    decrypted = zeros(1, numBlocks * blockSize, "uint8");

    previousBlock = ivBytes;

    for blockIndex = 1:numBlocks
        startIdx = (blockIndex - 1) * blockSize + 1;

        cipherBlock = ciphertextBytes(startIdx:startIdx + blockSize - 1);
        intermediate = aes.decryptBlock(cipherBlock, roundKeys);

        plainBlock = bitxor(intermediate, previousBlock);
        decrypted(startIdx:startIdx + blockSize - 1) = plainBlock;

        previousBlock = cipherBlock;
    end

    % Remove PKCS#7 Padding
    padAmount = decrypted(end);

    if padAmount < 1 || padAmount > blockSize
        error("decryptCBCMode:BadPadding", "Invalid PKCS#7 padding.");
    end

    plaintextBytes = decrypted(1:end - padAmount);
end
