disp("Running test_keygen.m ...");

key = otp.generateKey(16);

disp("Generated Key: ");
disp(key);

disp("Length of key: ");
disp(length(key));

disp("Data type: ");
disp(class(key));

if length(key) == 16 && isa(key, 'uint8')
    disp("TEST PASSED: Key generator working correctly.");
else
    disp("KTEST FAILED: Issue with key length or data type.");
end