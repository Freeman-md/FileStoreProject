disp("Running test_otp_text.m...")

plainText = "This is my first OTP text";

plainBytes = uint8(char(plainText));

keyBytes = generateKey(numel(plainBytes));

% Encrypt the plaintext using the generated key
cipherBytes = otpEncrypt(plainBytes, keyBytes);


% Decrypt the ciphertext using the generated key
recoveredBytes = otpDecrypt(cipherBytes, keyBytes);

% Convert the recovered bytes to plaintext
recoveredText = char(recoveredBytes);


disp("Original text: ");
disp(plainText);

disp("Cipher bytes: ");
disp(cipherBytes);

disp("Recovered text: ");
disp(recoveredText);

if strcmp(plainText, recoveredText)
    disp("TEST PASSED: OTP encrypt/decrypt works for text");
else
    disp("TEST FAILED: Recovered text does not match original");
end