function decryptFile(cipherPath, keyPath, outputPath)
    % OTP decrypt any file (binary-safe).

    % Load cipher
    fid = fopen(cipherPath, 'rb');
    cipherBytes = fread(fid, '*uint8')';
    fclose(fid);

    % Load key
    fid = fopen(keyPath, 'rb');
    keyBytes = fread(fid, '*uint8')';
    fclose(fid);

    % Decrypt
    plainBytes = otp.decrypt(cipherBytes, keyBytes);
    

    % Write plaintext
    fid = fopen(outputPath, 'wb');
    fwrite(fid, plainBytes, 'uint8');
    fclose(fid);
end
