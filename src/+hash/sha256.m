function hashHex = sha256(textInput)
%SHA256  Text-only SHA-256 wrapper. Returns lowercase hex string.

    arguments
        textInput char {mustBeText}
    end

    bytes = uint8(textInput);

    % Special-case empty string to avoid Java/MATLAB empty-array quirks
    if isempty(bytes)
        hashHex = "e3b0c44298fc1c149afbf4c8996fb924" + ...
                  "27ae41e4649b934ca495991b7852b855";
        return;
    end

    md = java.security.MessageDigest.getInstance("SHA-256");
    raw = md.digest(bytes);
    hashBytes = typecast(raw, "uint8");

    % Convert to lowercase hex string
    hashHex = lower(dec2hex(hashBytes).');
    hashHex = hashHex(:).';   % flatten to single row
end

function mustBeText(x)
    if ~(ischar(x) || isstring(x))
        error("sha256:InputNotText","Input must be char or string");
    end
end
