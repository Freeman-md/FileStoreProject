function main
% MAIN Entry point for CST4136 Secure File Store

    clc;
    addProjectPaths();

    isRunning = true;

    while isRunning
        printMainMenu();
        choice = input('Select an option: ', 's');

        switch choice
            case '1'
                runCaesarCipher();

            case '2'
                runOneTimePad();

            case '3'
                runXorStreamCipher();

            case '4'
                runAesEncryption();

            case '5'
                runHashing();

            case '6'
                runHmac();

            case '7'
                runRsaEncryption();

            case '8'
                runDiffieHellman();

            case '9'
                runEnvelopeEncryption();

            case '10'
                runKeyManagement();

            case '0'
                isRunning = false;
                disp('Exiting Secure File Store.');

            otherwise
                disp('Invalid option. Please try again.');
        end

        if isRunning
            pause();
            clc;
        end
    end
end

%% ---------------------- MENU ----------------------

function printMainMenu()
    disp('====================================');
    disp(' Secure File Store - CST4136');
    disp('====================================');
    disp('1. Caesar cipher (text)');
    disp('2. One-Time Pad (text)');
    disp('3. XOR stream cipher (text or file)');
    disp('4. AES encryption (ECB / CBC)');
    disp('5. Hash message');
    disp('6. HMAC (SHA-256)');
    disp('7. RSA encrypt / decrypt (text)');
    disp('8. Diffie-Hellman key exchange');
    disp('9. Envelope encryption (hybrid)');
    disp('10. Key management');
    disp('0. Exit');
    disp('------------------------------------');
end

%% ---------------------- OPERATIONS ----------------------

function runCaesarCipher()
    text = input('Enter text: ', 's');
    shift = input('Enter shift value: ');
    encrypted = caesar.encrypt(text, shift);
    decrypted = caesar.decrypt(encrypted, shift);

    disp(['Encrypted: ', encrypted]);
    disp(['Decrypted: ', decrypted]);
end

function runOneTimePad()
    text = input('Enter text: ', 's');
    [cipherText, key] = otp.encrypt(text);
    recovered = otp.decrypt(cipherText, key);

    disp(['Ciphertext: ', cipherText]);
    disp(['Recovered: ', recovered]);
end

function runXorStreamCipher()
    mode = input('Encrypt file (f) or text (t)? ', 's');

    seed = input('Enter numeric seed: ');

    if mode == 'f'
        inputFile = input('Input file path: ', 's');
        outputFile = input('Output file path: ', 's');

        data = readBinaryFile(inputFile);
        encrypted = xorstream.encrypt(data, seed);
        writeBinaryFile(outputFile, encrypted);

        disp('File encrypted successfully.');
    else
        text = input('Enter text: ', 's');
        cipher = xorstream.encrypt(text, seed);
        recovered = char(xorstream.decrypt(cipher, seed));

        disp(['Recovered: ', recovered]);
    end
end

function runAesEncryption()
    mode = input('Mode ECB (e) or CBC (c)? ', 's');
    text = input('Enter text: ', 's');

    key = keymgmt.generateAESKey();
    roundKeys = aes.keyExpansion(key);

    if mode == 'e'
        cipher = aes.encryptECBMode(text, roundKeys);
        recovered = aes.decryptECBMode(cipher, roundKeys);
    else
        [cipher, iv] = aes.encryptCBCMode(text, roundKeys);
        recovered = aes.decryptCBCMode(cipher, iv, roundKeys);
    end

    disp(['Recovered: ', char(recovered)]);
end

function runHashing()
    text = input('Enter text to hash: ', 's');
    hashValue = hash.sha256(text);
    disp(['SHA-256: ', hashValue]);
end

function runHmac()
    key = input('Enter key: ', 's');
    message = input('Enter message: ', 's');

    mac = hash.hmac_sha256(key, message);
    disp(['HMAC: ', mac]);
end

function runRsaEncryption()
    message = input('Enter short message: ', 's');

    [n, e, d] = rsa.generateKeys();
    cipher = rsa.encrypt(message, e, n);
    recovered = rsa.decrypt(cipher, d, n);

    disp(['Recovered: ', recovered]);
end

function runDiffieHellman()
    [p, g] = dh.generateParameters();

    [aPriv, aPub] = dh.generateKeyPair(p, g);
    [bPriv, bPub] = dh.generateKeyPair(p, g);

    secretA = dh.computeSharedSecret(bPub, aPriv, p);
    secretB = dh.computeSharedSecret(aPub, bPriv, p);

    disp(['Shared secret A: ', num2str(secretA)]);
    disp(['Shared secret B: ', num2str(secretB)]);
end

function runEnvelopeEncryption()
    message = input('Enter message: ', 's');

    [n, e, d] = rsa.generateKeys();
    publicKey = [e, n];
    privateKey = [d, n];

    aesKey = keymgmt.generateAESKey();
    roundKeys = aes.keyExpansion(aesKey);

    env = envelope.encryptMessage(message, publicKey, roundKeys);
    recovered = envelope.decryptMessage(env, privateKey, roundKeys);

    disp(['Recovered: ', char(recovered)]);
end

function runKeyManagement()
    key = keymgmt.generateAESKey();
    file = input('Enter file path to save AES key: ', 's');

    keymgmt.saveAESKey(key, file);
    loadedKey = keymgmt.loadAESKey(file);

    disp('AES key saved and loaded successfully.');
    disp(['Key length: ', num2str(numel(loadedKey))]);
end

%% ---------------------- HELPERS ----------------------

function addProjectPaths()
    projectRoot = fileparts(mfilename('fullpath'));
    addpath(genpath(projectRoot));
end