function tests = test_password_derivation
    tests = functiontests(localfunctions);
end

function testSameInputsProduceSameKey(testCase)
    password = "securePassword";
    salt = uint8([1 2 3 4 5]);
    iterations = 1000;

    key1 = keymgmt.deriveKeyFromPassword(password, salt, iterations);
    key2 = keymgmt.deriveKeyFromPassword(password, salt, iterations);

    verifyEqual(testCase, key1, key2);
end

function testDifferentSaltProducesDifferentKey(testCase)
    password = "securePassword";
    salt1 = uint8([1 2 3]);
    salt2 = uint8([9 8 7]);
    iterations = 500;

    key1 = keymgmt.deriveKeyFromPassword(password, salt1, iterations);
    key2 = keymgmt.deriveKeyFromPassword(password, salt2, iterations);

    verifyNotEqual(testCase, key1, key2);
end

function testDifferentIterationsProduceDifferentKey(testCase)
    password = "securePassword";
    salt = uint8([4 5 6]);

    key1 = keymgmt.deriveKeyFromPassword(password, salt, 100);
    key2 = keymgmt.deriveKeyFromPassword(password, salt, 200);

    verifyNotEqual(testCase, key1, key2);
end

function testKeyLength(testCase)
    password = "pwd";
    salt = uint8([0 1 2]);
    iterations = 10;

    key = keymgmt.deriveKeyFromPassword(password, salt, iterations);

    verifyEqual(testCase, numel(key), 16);
    verifyClass(testCase, key, 'uint8');
end
