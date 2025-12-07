function tests = test_ecb
    tests = functiontests(localfunctions);
end

% TEXT ECB TESTS 

function testECB_Text_MultiBlock(testCase)
    key = uint8(0:15);
    roundKeys = aes.keyExpansion(key);

    % 32 bytes → exactly 2 blocks
    text = 'This is a test message 1234';
    plaintextBytes = uint8(text);

    cipher = aes.encryptECBMode(plaintextBytes, roundKeys);
    recovered = aes.decryptECBMode(cipher, roundKeys);

    verifyEqual(testCase, recovered, plaintextBytes);
end

function testECB_Text_WithPadding(testCase)
    key = uint8(10:25);
    roundKeys = aes.keyExpansion(key);

    % 30 bytes → NOT multiple of 16 → padding required (PKCS#7)
    text = 'Short text needing padding!!';
    plaintextBytes = uint8(text);

    cipher = aes.encryptECBMode(plaintextBytes, roundKeys);
    recovered = aes.decryptECBMode(cipher, roundKeys);

    verifyEqual(testCase, recovered, plaintextBytes);
end

% BINARY ECB TESTS

function testECB_Binary_MultiBlock(testCase)
    key = uint8(100:115);
    roundKeys = aes.keyExpansion(key);

    % 48 bytes of random binary (3 blocks)
    binaryData = uint8(randi([0 255], 1, 48));

    cipher = aes.encryptECBMode(binaryData, roundKeys);
    recovered = aes.decryptECBMode(cipher, roundKeys);

    verifyEqual(testCase, recovered, binaryData);
end

function testECB_Binary_DifferentBlocksProduceDifferentCipher(testCase)
    key = uint8(200:215);
    roundKeys = aes.keyExpansion(key);

    blockA = uint8(zeros(1,16));      % all zero block
    blockB = uint8(ones(1,16));       % all ones block

    cipherA = aes.encryptECBMode(blockA, roundKeys);
    cipherB = aes.encryptECBMode(blockB, roundKeys);

    verifyNotEqual(testCase, cipherA, cipherB);
end

function testECB_Deterministic_SameBlockSameCipher(testCase)
    key = uint8(50:65);
    roundKeys = aes.keyExpansion(key);

    block = uint8(5 .* ones(1,16));   % constant block

    cipher1 = aes.encryptECBMode(block, roundKeys);
    cipher2 = aes.encryptECBMode(block, roundKeys);

    verifyEqual(testCase, cipher1, cipher2);
end
