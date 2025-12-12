function tests = test_aes_keymgmt
    tests = functiontests(localfunctions)
end


function testKeyLength(testCase)
    key = keymgmt.generateAESKey();
    verifyEqual(testCase, numel(key), 16);
    verifyClass(testCase, key, 'uint8');
end

function testSaveLoadRoundTrip(testCase)
    key = keymgmt.generateAESKey();
    file = tempname;

    keymgmt.saveAESKey(key, file);
    loadedKey = keymgmt.loadAESKey(file);

    verifyEqual(testCase, loadedKey, key);
end

function testRandomness(testcase)
    key1 = keymgmt.generateAESKey();
    key2 = keymgmt.generateAESKey();

    verifyNotEqual(testcase, key1, key2);
end