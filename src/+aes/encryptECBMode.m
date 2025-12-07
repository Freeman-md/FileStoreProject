function ciphertextBytes = encryptECBMode(inputBytes, roundKeys)
%AES.ENCRYPTECBMODE Encrypt arbitrary-length data using AES-128 in ECB mode.

    if ischar(inputBytes) || isstring(inputBytes)
        inputBytes = uint8(inputBytes);
    end

    if ~isa(inputBytes, 'uint8')
        error("encryptECBMode:InvalidInput", ...
              "Input must be uint8, char, or string.");
    end

    blockSize = 16;
    inputBytes = inputBytes(:).';  % ensure row vector
    dataLength = numel(inputBytes);

    % PKCS#7 Padding
    padAmount = blockSize - mod(dataLength, blockSize);
    if padAmount == 0
        padAmount = blockSize;
    end
    paddedBytes = [inputBytes, repmat(uint8(padAmount), 1, padAmount)];

    % Encrypt each block independently
    numBlocks = numel(paddedBytes) / blockSize;
    ciphertextBytes = zeros(1, numel(paddedBytes), 'uint8');

    for blockIndex = 1:numBlocks
        startIdx = (blockIndex - 1) * blockSize + 1;
        block = paddedBytes(startIdx:startIdx + blockSize - 1);
        ciphertextBytes(startIdx:startIdx + blockSize - 1) = ...
            aes.encryptBlock(block, roundKeys);
    end
end
