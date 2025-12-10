function tests = test_simpleHash
    tests = functiontests(localfunctions);
end

function test_repeatability(~)
    hash1 = hash.simpleHash("hello");
    hash2 = hash.simpleHash("hello");
    assert(isequal(hash1, hash2));
end

function test_variation(~)
    h1 = hash.simpleHash("hello");
    h2 = hash.simpleHash("hellp");
    assert(~isequal(h1, h2));
end
