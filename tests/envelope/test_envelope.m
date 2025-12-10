function tests = test_envelope
    tests = functiontests(localfunctions);
end

function testRoundTrip(testCase)
    [n, e, d] = rsa.generateKeys();
    pub  = [e, n];
    priv = [d, n];

    roundKeys = aes.keyExpansion(uint8(randi([0 255],1,16)));

    plaintext = "Hello Hybrid Crypto!";
    out = envelope.encryptMessage(plaintext, pub, roundKeys);
    recovered = envelope.decryptMessage(out, priv, roundKeys);
    recovered = char(recovered);

    verifyEqual(testCase, recovered, char(plaintext));
end

function testAESKeyHidden(testCase)
    [n, e, d] = rsa.generateKeys();
    pub  = [e, n];
    priv = [d, n];

    roundKeys = aes.keyExpansion(uint8(randi([0 255],1,16)));

    plaintext = "secret message";
    out = envelope.encryptMessage(plaintext, pub, roundKeys);

    unwrap = rsa.decrypt(out.encryptedKey, priv(1), priv(2));
verifyNotEqual(testCase, unwrap, out.encryptedKey);

end

function testIVMismatch(testCase)
    [n, e, d] = rsa.generateKeys();
    pub  = [e, n];
    priv = [d, n];

    roundKeys = aes.keyExpansion(uint8(randi([0 255],1,16)));

    plaintext = "Testing IV behaviour";
    out = envelope.encryptMessage(plaintext, pub, roundKeys);

    tampered = out;
    tampered.iv(1) = bitxor(tampered.iv(1), uint8(1));

    wrong = char(envelope.decryptMessage(tampered, priv, roundKeys));
    verifyNotEqual(testCase, wrong, char(plaintext));
end

function testRandomnessDifferentCiphertexts(testCase)
    [n, e, d] = rsa.generateKeys();
    pub  = [e, n];

    roundKeys = aes.keyExpansion(uint8(randi([0 255],1,16)));

    plaintext = "Same message";

    out1 = envelope.encryptMessage(plaintext, pub, roundKeys);
    out2 = envelope.encryptMessage(plaintext, pub, roundKeys);

    verifyNotEqual(testCase, out1.ciphertext(:), out2.ciphertext(:));
end
