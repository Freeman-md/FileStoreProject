function tests = test_rsa
    tests = functiontests(localfunctions);
end

function testKeyGeneration(testCase)
    [n, e, d] = rsa.generateKeys();

    verifyTrue(testCase, n > 0);
    verifyTrue(testCase, e > 1);
    verifyTrue(testCase, d > 1);

    % For p=61, q=53 used in generateKeys()
    phi = (61 - 1) * (53 - 1);
    verifyEqual(testCase, mod(e * d, phi), 1);
end

function testModExp(testCase)
    base = 5;
    exponent = 123;
    modn = 97;

    expected = powermod(base, exponent, modn);
    actual   = rsa.modExp(base, exponent, modn);

    verifyEqual(testCase, actual, expected);
end


function testModInverse(testCase)
    inv = rsa.modInverse(17, 3120);
    verifyEqual(testCase, mod(inv * 17, 3120), 1);
end

function testEncryptDecryptRoundTrip(testCase)
    text = 'A';   % must be < n

    [n, e, d] = rsa.generateKeys();

    cipher    = rsa.encrypt(text, e, n);
    recovered = rsa.decrypt(cipher, d, n);

    verifyEqual(testCase, recovered, text);
end

