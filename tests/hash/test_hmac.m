function tests = test_hmac
    tests = functiontests(localfunctions);
end

function test_rfc4231_case1(~)
    key = "Jefe";
    msg = "what do ya want for nothing?";
    expected = "5bdcc146bf60754e6a042426089575c7" + ...
               "5a003f089d2739839dec58b964ec3843";

    mac = hash.hmac_sha256(key, msg);
    assert(strcmp(mac, expected));
end

function test_same_input_same_mac(~)
    m1 = hash.hmac_sha256("key", "message");
    m2 = hash.hmac_sha256("key", "message");
    assert(strcmp(m1, m2));
end

function test_different_key(~)
    m1 = hash.hmac_sha256("key1", "message");
    m2 = hash.hmac_sha256("key2", "message");
    assert(~strcmp(m1, m2));
end

function test_different_message(~)
    m1 = hash.hmac_sha256("key", "message1");
    m2 = hash.hmac_sha256("key", "message2");
    assert(~strcmp(m1, m2));
end
