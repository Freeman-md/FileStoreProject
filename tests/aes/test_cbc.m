function tests = test_cbc
    tests = functiontests(localfunctions);
end

%% TEXT CBC TESTS 

function testCBC_Text_MultiBlock_RoundTrip(testCase)
    key = uint8(0:15);
    roundKeys = aes.keyExpansion(key);

    text = 'This is a CBC mode test message!';
    plaintextBytes = uint8(text);

    [cipher, iv] = aes.encryptCBCMode(plaintextBytes, roundKeys);
    recovered = aes.decryptCBCMode(cipher, iv, roundKeys);

    verifyEqual(testCase, recovered, plaintextBytes);
end


function testCBC_Text_Padding(testCase)
    key = uint8(10:25);
    roundKeys = aes.keyExpansion(key);

    % Length not multiple of 16 → padding required
    text = 'Pad me in CBC mode.';
    plaintextBytes = uint8(text);

    [cipher, iv] = aes.encryptCBCMode(plaintextBytes, roundKeys);
    recovered = aes.decryptCBCMode(cipher, iv, roundKeys);

    verifyEqual(testCase, recovered, plaintextBytes);
end


%%  BINARY CBC TESTS

function testCBC_Binary_MultiBlock_RoundTrip(testCase)
    key = uint8(50:65);
    roundKeys = aes.keyExpansion(key);

    binaryData = uint8(randi([0 255], 1, 64)); % 4 blocks

    [cipher, iv] = aes.encryptCBCMode(binaryData, roundKeys);
    recovered = aes.decryptCBCMode(cipher, iv, roundKeys);

    verifyEqual(testCase, recovered, binaryData);
end


%% CBC MODE PROPERTIES

function testCBC_DifferentIV_ProducesDifferentCipher(testCase)
    key = uint8(100:115);
    roundKeys = aes.keyExpansion(key);

    data = uint8('same message every time');

    [cipher1, iv1] = aes.encryptCBCMode(data, roundKeys);
    [cipher2, iv2] = aes.encryptCBCMode(data, roundKeys);

    % Ciphertexts must differ because IV is random
    verifyNotEqual(testCase, cipher1, cipher2);
    verifyNotEqual(testCase, iv1, iv2);
end


function testCBC_IdenticalBlocks_DoNotProduceIdenticalCipher(testCase)
    key = uint8(200:215);
    roundKeys = aes.keyExpansion(key);

    % 2 identical blocks
    block = uint8('1234567890ABCDEF'); % 16 bytes
    data = [block, block];

    [cipher, ~] = aes.encryptCBCMode(data, roundKeys);

    c1 = cipher(1:16);
    c2 = cipher(17:32);

    % In CBC, identical plaintext blocks should NOT encrypt to same ciphertext
    verifyNotEqual(testCase, c1, c2);
end


function testCBC_FailsWithWrongIV(testCase)
    key = uint8(0:15);
    roundKeys = aes.keyExpansion(key);

    data = uint8('testing wrong iv');

    [cipher, ~] = aes.encryptCBCMode(data, roundKeys);

    wrongIV = uint8(randi([0 255], 1, 16));

    recovered_wrong = aes.decryptCBCMode(cipher, wrongIV, roundKeys);

    % Wrong IV should not produce correct plaintext
    verifyNotEqual(testCase, recovered_wrong, data);
end
