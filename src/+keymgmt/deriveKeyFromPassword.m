function key = deriveKeyFromPassword(password, salt, iterations)
%DERIVEKEYFROMPASSWORD Derive AES-128 key from password (PBKDF2-style)
%
%   key = deriveKeyFromPassword(password, salt, iterations)
%
%   password   - char or string
%   salt       - uint8 array
%   iterations - positive integer
%
%   Output:
%       key - 16-byte uint8 AES key

    if ~(ischar(password) || isstring(password))
        error('Password must be char or string');
    end

    if ~isa(salt, 'uint8')
        error('Salt must be uint8');
    end

    if ~isscalar(iterations) || iterations < 1
        error('Iterations must be a positive integer');
    end

    % Convert password to bytes
    pwdBytes = uint8(char(password));

    % Initial input = password || salt
    buffer = [pwdBytes, salt];

    % Repeated SHA-256 hashing
    for i = 1:iterations
        buffer = sha256_bytes(buffer);
    end

    % Take first 16 bytes for AES-128 key
    key = buffer(1:16);
end


%% Internal helper: SHA-256 on raw bytes → uint8
function hashBytes = sha256_bytes(byteArray)
    md = java.security.MessageDigest.getInstance("SHA-256");
    raw = md.digest(uint8(byteArray));
    hashBytes = typecast(raw, 'uint8').';
end
