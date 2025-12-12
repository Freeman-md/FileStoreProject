function saveRSAKeys(publicKey, privateKey, filepath)
%SAVERSAKEYS Save RSA public/private key pairs
%   publicKey  = [e, n]
%   privateKey = [d, n]

    if ~isnumeric(publicKey) || numel(publicKey) ~= 2
        error('Public RSA key must be [e, n]');
    end

    if ~isnumeric(privateKey) || numel(privateKey) ~= 2
        error('Private RSA key must be [d, n]');
    end

    % Ensure .mat extension
    if ~endsWith(filepath, '.mat')
        filepath = filepath + ".mat";
    end

    e = publicKey(1);
    n = publicKey(2);
    d = privateKey(1);

    save(filepath, 'e', 'd', 'n');
end
