disp("Running otp/test_file.m ...");

inputFile = "../../data/sample.txt";
encFile   = "../../data/sample.enc";
decFile   = "../../data/sample.dec.txt";


plainBytes = fileread(inputFile);
plainBytes = uint8(plainBytes);


keyBytes = otp.generateKey(numel(plainBytes));

% Encrypt and save encrypted bytes
cipherBytes = otp.encrypt(plainBytes, keyBytes);
fid = fopen(encFile, 'w');
fwrite(fid, cipherBytes, 'uint8');
fclose(fid);

% Decrypt and save recovered bytes
recoveredBytes = otp.decrypt(cipherBytes, keyBytes);
fid = fopen(decFile, 'w');
fwrite(fid, recoveredBytes, 'uint8');
fclose(fid);


recoveredText = fileread(decFile);


disp("Original:");
disp(char(plainBytes));

disp("Recovered:");
disp(recoveredText);

if strcmp(char(plainBytes), recoveredText)
    disp("TEST PASSED: File OTP encryption/decryption works.");
else
    disp("TEST FAILED: File mismatch.");
end