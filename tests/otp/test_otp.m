function tests = test_otp
    tests = functiontests(localfunctions);
end

function testRoundTrip(testCase)
    text = 'otp test string';

    [cipher, key] = otp.encrypt(text);
    recovered     = otp.decrypt(cipher, key);

    verifyEqual(testCase, recovered, text);
end
