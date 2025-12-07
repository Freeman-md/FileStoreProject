function tests = test_block
    tests = functiontests(localfunctions);
end

function test_AES128_single_block_encrypt_decrypt(testCase)
    % NIST AES-128 Known Test Vector
    plainHex = '00112233445566778899aabbccddeeff';
    keyHex   = '000102030405060708090a0b0c0d0e0f';
    cipherHexExpected = '69c4e0d86a7b0430d8cdb78070b4c55a';

    % Convert to uint8 bytes
    plainBlock  = uint8(hex2dec(reshape(plainHex, 2, []).').');
    keyBytes    = uint8(hex2dec(reshape(keyHex, 2, []).').');

    % Expand key
    roundKeys = aes.keyExpansion(keyBytes);

    % Encrypt
    cipherBlock = aes.encryptBlock(plainBlock, roundKeys);
    cipherHex   = reshape(lower(dec2hex(cipherBlock, 2)).', 1, []);

    % Compare with expected NIST ciphertext
    verifyEqual(testCase, cipherHex, cipherHexExpected);

    % Decrypt and ensure round-trip
    recoveredBlock = aes.decryptBlock(cipherBlock, roundKeys);

    verifyEqual(testCase, recoveredBlock, plainBlock);
end
