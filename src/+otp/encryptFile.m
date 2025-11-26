function encryptFile(inputPath, cipherPath, keyPath)
    % OTP encrypt any file (binary-safe).

    % Load file as bytes
    fid = fopen(inputPath, 'rb');
    plainBytes = fread(fid, '*uint8')';
    fclose(fid);

    % Generate key (row vector)
    keyBytes = otp.generateKey(numel(plainBytes));

    % Encrypt
    cipherBytes = otp.encrypt(plainBytes, keyBytes);

    % Write cipher
    fid = fopen(cipherPath, 'wb');
    fwrite(fid, cipherBytes, 'uint8');
    fclose(fid);

    % Write key
    fid = fopen(keyPath, 'wb');
    fwrite(fid, keyBytes, 'uint8');
    fclose(fid);
end
