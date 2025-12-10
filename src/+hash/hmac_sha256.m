function macHex = hmac_sha256(keyInput, msgInput)
%HMAC_SHA256  Text-only HMAC using SHA-256. Returns lowercase hex.

    arguments
        keyInput {mustBeText}
        msgInput {mustBeText}
    end

    keyBytes = uint8(char(keyInput));
    msgBytes = uint8(char(msgInput));

    blockSize = 64; % SHA-256 block size

    % If key too long, hash it and convert to bytes
    if numel(keyBytes) > blockSize
        hexKey = hash.sha256(char(keyBytes));
        keyBytes = hexToBytes(hexKey);
    end

    % Pad to block size
    if numel(keyBytes) < blockSize
        keyBytes(end+1:blockSize) = 0;
    end

    ipad = uint8(54 * ones(1, blockSize));  % 0x36
    opad = uint8(92 * ones(1, blockSize));  % 0x5c

    inner = bitxor(keyBytes, ipad);
    innerInput = [inner, msgBytes];                % both row vectors
    innerHex = sha256_bytes(innerInput);
    innerBytes = hexToBytes(innerHex).';           % force row vector

    outer = bitxor(keyBytes, opad);
    outerInput = [outer, innerBytes];              % both row vectors
    macHex = sha256_bytes(outerInput);
end


%% SHA256 on raw bytes
function hexStr = sha256_bytes(byteArray)
    md = java.security.MessageDigest.getInstance("SHA-256");
    raw = md.digest(uint8(byteArray));
    hexStr = lower(reshape(dec2hex(typecast(raw,"uint8")).',1,[]));
end

%% Hex-string → uint8 bytes
function bytes = hexToBytes(hexStr)
    hexStr = char(hexStr);
    pairs = reshape(hexStr, 2, []).';
    bytes = uint8(hex2dec(pairs));
end


function mustBeText(x)
    if ~(ischar(x) || isstring(x))
        error("hmac_sha256:InputNotText","Input must be char or string");
    end
end
