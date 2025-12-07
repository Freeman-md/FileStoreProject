function tests = test_binary
%TEST_BINARY Unit tests for XOR stream cipher (binary mode)
    tests = functiontests(localfunctions);
end

function testRoundTripBinary(testCase)
    % Generate sample binary data
    originalBinaryData = uint8(randi([0, 255], 1, 1024));
    seedValue = 54321;

    encryptedData = xorstream.encrypt(originalBinaryData, seedValue);
    decryptedData = xorstream.decrypt(encryptedData, seedValue);

    verifyEqual(testCase, decryptedData, originalBinaryData);
end

function testBinaryFileStyleInput(testCase)
    % Simulate small PNG-like binary header followed by random bytes
    simulatedFileBytes = uint8([137 80 78 71 13 10 26 10 randi([0,255],1,100)]);
    seedValue = 777;

    encryptedData = xorstream.encrypt(simulatedFileBytes, seedValue);
    decryptedData = xorstream.decrypt(encryptedData, seedValue);

    verifyEqual(testCase, decryptedData, simulatedFileBytes);
end

function testDifferentSeedsProduceDifferentCipherOutputs(testCase)
    binaryData = uint8(randi([0,255], 1, 256));

    encryptedWithSeedA = xorstream.encrypt(binaryData, 111);
    encryptedWithSeedB = xorstream.encrypt(binaryData, 222);

    verifyNotEqual(testCase, encryptedWithSeedA, encryptedWithSeedB);
end
