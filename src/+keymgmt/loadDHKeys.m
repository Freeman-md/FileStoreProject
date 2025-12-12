function [p, g, privateKey, publicKey] = loadDHKeys(filepath)
%LOADDHKEYS Load Diffie-Hellman parameters and key pair

    % Ensure .mat extension
    if ~endsWith(filepath, '.mat')
        filepath = filepath + ".mat";
    end

    if ~isfile(filepath)
        error('DH key file not found');
    end

    data = load(filepath);

    requiredFields = {'p', 'g', 'privateKey', 'publicKey'};
    for i = 1:numel(requiredFields)
        if ~isfield(data, requiredFields{i})
            error('Invalid DH key file format');
        end
    end

    p = data.p;
    g = data.g;
    privateKey = data.privateKey;
    publicKey = data.publicKey;
end
