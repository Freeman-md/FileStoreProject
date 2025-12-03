function tests = test_caesar
%TEST_CAESAR Unit tests for Caesar cipher
    tests = functiontests(localfunctions);
end

function testEncryptBasic(testCase)
    actual = caesar.encrypt('abc', 3);
    expected = 'def';
    verifyEqual(testCase, actual, expected);
end

function testEncryptWrap(testCase)
    actual = caesar.encrypt('xyz', 3);
    expected = 'abc';
    verifyEqual(testCase, actual, expected);
end

function testDecryptBasic(testCase)
    actual = caesar.decrypt('def', 3);
    expected = 'abc';
    verifyEqual(testCase, actual, expected);
end

function testDecryptWrap(testCase)
    actual = caesar.decrypt('abc', 3);
    expected = 'xyz';
    verifyEqual(testCase, actual, expected);
end

function testNonLettersRemain(testCase)
    actual = caesar.encrypt('hello world!', 5);
    expected = 'mjqqt btwqi!';
    verifyEqual(testCase, actual, expected);
end
