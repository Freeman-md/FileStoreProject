function tests = test_rsa_keymgmt
    tests = functiontests(localfunctions);
end

function testSaveLoadPreservesValues(testCase)
    [n, e, d] = rsa.generateKeys();

    pub  = [e, n];
    priv = [d, n];

    file = tempname;
    keymgmt.saveRSAKeys(pub, priv, file);

    [loadedPub, loadedPriv] = keymgmt.loadRSAKeys(file);

    verifyEqual(testCase, loadedPub, pub);
    verifyEqual(testCase, loadedPriv, priv);
end

function testLoadedKeysEncryptDecrypt(testCase)
    [n, e, d] = rsa.generateKeys();

    pub  = [e, n];
    priv = [d, n];

    file = tempname;
    keymgmt.saveRSAKeys(pub, priv, file);

    [pub2, priv2] = keymgmt.loadRSAKeys(file);

    msg = 'A';  % must fit modulus
    cipher = rsa.encrypt(msg, pub2(1), pub2(2));
    recovered = rsa.decrypt(cipher, priv2(1), priv2(2));

    verifyEqual(testCase, recovered, msg);
end
