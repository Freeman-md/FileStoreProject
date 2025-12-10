function out = encryptMessage(plaintext, publicKey, roundKeys)
% envelope.encryptMessage

% Implements Envelope Encryption:
% 1. Generate random AES-128 key (16 bytes)
% 2. AES-CBC encrypt the plaintext
% 3. RSA-encrypt the AES key using receiver's public key

    % Ensure plaintext as uint8
    if ischar(plaintext) || isstring(plaintext)
        plaintext = uint8(plaintext);
    elseif ~isa(plaintext, 'uint8')
        error('Plaintext must be char, string, or uint8.');
    end

    % --- STEP 1: Generate AES-128 key (16 bytes) ---
    aesKey = uint8(randi([0 255], 1, 16));

    % --- STEP 2: Generate IV (16 bytes) ---
    iv = uint8(randi([0 255], 1, 16));

    % --- STEP 3: AES-CBC ENCRYPTION ---
    ciphertext = aes.encryptCBCMode(plaintext, aesKey, iv, roundKeys);

    % --- STEP 4: RSA ENCRYPT THE AES KEY ---
    encryptedKey = rsa.encrypt(aesKey, publicKey);

    % Structure output
    out = struct( ...
        'encryptedKey', encryptedKey, ...   % RSA(cipherKey)
        'ciphertext', ciphertext, ...       % AES-CBC output
        'iv', iv ...                        % AES IV
    );
end
