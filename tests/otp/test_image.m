disp("Running otp/test_image.m ...");

originFilePath     = "../../data/test.png";
encryptedFilePath  = "../../data/test.png.enc";
keyPath            = "../../data/test.png.key";
decryptedFilePath  = "../../data/test.png.dec";

% Create PNG image
img = uint8(repmat(linspace(0,255,128),128,1));
imwrite(img, originFilePath);

% Encrypt + decrypt
otp.encryptFile(originFilePath, encryptedFilePath, keyPath);
otp.decryptFile(encryptedFilePath, keyPath, decryptedFilePath);

% Compare raw bytes
fid = fopen(originFilePath, 'rb');  
originBytes = fread(fid, '*uint8')'; 
fclose(fid);

fid = fopen(decryptedFilePath,  'rb');  
decryptedFilePathBytes  = fread(fid, '*uint8')'; 
fclose(fid);

if isequal(originBytes, decryptedFilePathBytes)
    disp("TEST PASSED: Image round-trip OK");
else
    disp("TEST FAILED: Image mismatch.");
end
