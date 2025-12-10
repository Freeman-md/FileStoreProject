function tests = test_dh
    tests = functiontests(localfunctions);
end

function testSharedSecretAgreement(testCase)
    [p, g] = dh.generateParameters();

    [aPriv, aPub] = dh.generateKeyPair(p, g);
    [bPriv, bPub] = dh.generateKeyPair(p, g);

    aSecret = dh.computeSharedSecret(bPub, aPriv, p);
    bSecret = dh.computeSharedSecret(aPub, bPriv, p);

    verifyEqual(testCase, aSecret, bSecret);
end

function testPublicKeyRange(testCase)
    [p, g] = dh.generateParameters();
    [~, pub] = dh.generateKeyPair(p, g);

    verifyGreaterThan(testCase, pub, 0);
    verifyLessThan(testCase, pub, p);
end

function testDeterministicSecret(testCase)
    [p, g] = dh.generateParameters();

    priv = 7;
    pub = rsa.modExp(g, priv, p);

    s1 = dh.computeSharedSecret(pub, priv, p);
    s2 = dh.computeSharedSecret(pub, priv, p);

    verifyEqual(testCase, s1, s2);
end
