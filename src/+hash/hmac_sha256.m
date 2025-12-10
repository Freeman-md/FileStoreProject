function macHex = hmac_sha256(keyInput, msgInput)
%HMAC_SHA256  Text-only HMAC using SHA-256. Returns lowercase hex.

    arguments
        keyInput char { mustBeText }
        msgInput char { mustBeText }
    end

    keyBytes = uint8(keyInput);
    msgBytes = uint8(msgInput);

    blockSize = 64;

    if numel(keyBytes) > blockSize
        keyBytes = uint8(hex2dec(reshape(hash.sha256(char(keyBytes)),2,[])).');
    end

    if numel(keyBytes) < blockSize
        keyBytes(end+1:blockSize) = 0;
    end

    ipad = uint8(54 * ones(1, blockSize));  % 0x36
    opad = uint8(92 * ones(1, blockSize));  % 0x5c

    inner = bitxor(keyBytes, ipad);
    innerHashHex = hash.sha256([char(inner) char(msgBytes)]);
    innerHashBytes = uint8(hex2dec(reshape(innerHashHex,2,[])).');

    outer = bitxor(keyBytes, opad);
    finalHex = hash.sha256([char(outer) char(innerHashBytes)]);

    macHex = lower(finalHex);
end

function mustBeText(x)
    if ~(ischar(x) || isstring(x))
        error("hmac_sha256:InputNotText","Input must be char or string");
    end
end