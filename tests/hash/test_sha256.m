function tests = test_sha256
    tests = functiontests(localfunctions);
end

function test_empty_string(~)
    expected = "e3b0c44298fc1c149afbf4c8996fb924" + ...
               "27ae41e4649b934ca495991b7852b855";
    output = hash.sha256("");
    assert(strcmp(output, expected));
end

function test_abc(~)
    expected = "ba7816bf8f01cfea414140de5dae2223" + ...
               "b00361a396177a9cb410ff61f20015ad";
    output = hash.sha256("abc");
    assert(strcmp(output, expected));
end