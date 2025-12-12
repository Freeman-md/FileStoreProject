function tests = test_dh_keymgmt
    tests = functiontests(localfunctions);
end

function testSaveLoadPreservesSharedSecret(testCase)
    % Generate parameters
    [p, g] = dh.generateParameters();

    % User A
    [aPriv, aPub] = dh.generateKeyPair(p, g);

    % User B
    [bPriv, bPub] = dh.generateKeyPair(p, g);

    % Save A's keys
    file = tempname;
    keymgmt.saveDHKeys(p, g, aPriv, aPub, file);

    % Load A's keys
    [p2, g2, aPriv2, aPub2] = keymgmt.loadDHKeys(file);

    % Compute shared secrets
    secret1 = dh.computeSharedSecret(bPub, aPriv, p);
    secret2 = dh.computeSharedSecret(bPub, aPriv2, p2);

    verifyEqual(testCase, secret1, secret2);
end

function testLoadedParametersValid(testCase)
    [p, g] = dh.generateParameters();
    [priv, pub] = dh.generateKeyPair(p, g);

    file = tempname;
    keymgmt.saveDHKeys(p, g, priv, pub, file);

    [p2, g2, priv2, pub2] = keymgmt.loadDHKeys(file);

    verifyEqual(testCase, p2, p);
    verifyEqual(testCase, g2, g);
    verifyEqual(testCase, priv2, priv);
    verifyEqual(testCase, pub2, pub);
end
