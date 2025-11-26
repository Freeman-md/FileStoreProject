disp("Running otp/test_binary.m ...");

originFilePath    = "../../data/test.bin";
encryptedFilePath = "../../data/test.bin.enc";
keyPath           = "../../data/test.bin.key";
decryptedFilePath = "../../data/test.bin.dec";

% Create 1 KB random binary file
bytes = uint8(randi([0, 255], 1, 1024)); 
fid = fopen(originFilePath, 'wb');
fwrite(fid, bytes, 'uint8');
fclose(fid);

% Encrypt + decrypt
otp.encryptFile(originFilePath, encryptedFilePath, keyPath);
otp.decryptFile(encryptedFilePath, keyPath, decryptedFilePath);

% Load decrypted bytes
fid = fopen(decryptedFilePath, 'rb');
decryptedBytes = fread(fid, '*uint8')'; % transpose to row vector - fread always returns column vecotr
fclose(fid);

disp(numel(bytes));
disp(numel(decryptedBytes));

if isequal(bytes, decryptedBytes)
    disp("TEST PASSED: Binary round-trip OK");
else
    disp("TEST FAILED: Binary mismatch");
end
