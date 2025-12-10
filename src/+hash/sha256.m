function hashHexOutput = sha256(textInput)
%SHA256  Text-only SHA-256 wrapper. Returns lowercase hex.

    arguments
        textInput {mustBeText}
    end

    bytes = uint8(textInput)

    md = java.security.MessageDigest.getInstance("SHA-256");
    hashBytes = typecast(md.digest(bytes), "uint8");

    % Convert to lowercase hex string
    hashHexOutput = lower(dec2hex(hashBytes).');
    hashHexOutput = hashHexOutput(:).'; % reshape to row

end

function mustBeText(x)
    if ~(ischar(x) || isstring(x))
        error("sha256:InputNotText","Input must be char or string");
    end
end