function saveDHKeys(p, g, privateKey, publicKey, filepath)
%SAVEDHKEYS Save Diffie-Hellman parameters and key pair
%   p, g        - DH parameters
%   privateKey  - user's private scalar
%   publicKey   - user's public value
%   filepath    - output file path

    if ~isscalar(p) || ~isscalar(g)
        error('DH parameters p and g must be scalars');
    end

    if ~isscalar(privateKey) || ~isscalar(publicKey)
        error('DH keys must be scalar values');
    end

    % Ensure .mat extension
    if ~endsWith(filepath, '.mat')
        filepath = filepath + ".mat";
    end

    save(filepath, 'p', 'g', 'privateKey', 'publicKey');
end
