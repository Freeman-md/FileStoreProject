function tests = test_text
%TEST_TEXT Unit tests for XOR stream cipher (text mode)
    tests = functiontests(localfunctions);
end

function testRoundTrip_text(testCase)
    plainText = 'this is a stream cipher test';
    seed      = 12345;

    cipherBytes      = xorstream.encrypt(plainText, seed);
    recoveredBytes   = xorstream.decrypt(cipherBytes, seed);

    % Convert recovered bytes back to char for comparison
    recoveredText = char(recoveredBytes);

    verifyEqual(testCase, recoveredText, plainText);
end

function testDifferentSeedsProduceDifferentCipher(testCase)
    text = 'hello world';

    c1 = xorstream.encrypt(text, 10);
    c2 = xorstream.encrypt(text, 20);

    verifyNotEqual(testCase, c1, c2);
end

function testSeedReproducesSameCipher(testCase)
    text = 'deterministic test';

    c1 = xorstream.encrypt(text, 999);
    c2 = xorstream.encrypt(text, 999);

    verifyEqual(testCase, c1, c2);
end
