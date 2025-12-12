function [publicKey, privateKey] = loadRSAKeys(filepath)
%LOADRSAKEYS Load RSA public/private key pairs

    % Ensure .mat extension
    if ~endsWith(filepath, '.mat')
        filepath = filepath + ".mat";
    end

    if ~isfile(filepath)
        error('RSA key file not found');
    end

    data = load(filepath);

    if ~isfield(data, 'e') || ~isfield(data, 'd') || ~isfield(data, 'n')
        error('Invalid RSA key file format');
    end

    publicKey  = [data.e, data.n];
    privateKey = [data.d, data.n];
end
