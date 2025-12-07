function [ciphertextBytes, ivBytes] = encryptCBCMode(inputBytes, roundKeys)
%AES.ENCRYPTCBCMODE Encrypt data using AES-128 in CBC mode with PKCS#7 padding.
%
%   [ciphertextBytes, ivBytes] = aes.encryptCBCMode(inputBytes, roundKeys)

    if isstring(inputBytes)
        inputBytes = char(inputBytes);
    end

    if ischar(inputBytes)
        inputBytes = uint8(inputBytes);
    end

    if ~isa(inputBytes, "uint8")
        error("encryptCBCMode:InvalidInput", ...
              "Input must be uint8, char, or string.");
    end

    blockSize = 16;
    inputBytes = inputBytes(:).';  % row vector
    dataLength = numel(inputBytes);

    % PKCS#7 padding (same as ECB)
    padAmount = blockSize - mod(dataLength, blockSize);
    if padAmount == 0
        padAmount = blockSize;
    end
    paddedBytes = [inputBytes, repmat(uint8(padAmount), 1, padAmount)];

    % Generate random IV
    ivBytes = uint8(randi([0 255], 1, blockSize));

    numBlocks = numel(paddedBytes) / blockSize;
    ciphertextBytes = zeros(1, numBlocks * blockSize, "uint8");

    previousBlock = ivBytes;

    for blockIndex = 1:numBlocks
        startIdx = (blockIndex - 1) * blockSize + 1;
        plainBlock = paddedBytes(startIdx:startIdx + blockSize - 1);

        xoredBlock = bitxor(plainBlock, previousBlock);
        cipherBlock = aes.encryptBlock(xoredBlock, roundKeys);

        ciphertextBytes(startIdx:startIdx + blockSize - 1) = cipherBlock;
        previousBlock = cipherBlock;
    end
end
