function outputBytes = decrypt(cipherBytes, seed)
%XORSTREAM.DECRYPT Decrypt text or binary using PRNG-based XOR stream cipher.

    if ischar(cipherBytes)
        cipherBytes = uint8(cipherBytes);
    elseif isa(cipherBytes, 'uint8')
        cipherBytes = cipherBytes(:)';
    else
        error('xorstreamDecrypt:InvalidInputType', ...
          'Cipher data must be char or uint8.');
    end

    % Generate the same keystream used in encryption
    keystream = xorstream.generateKeystream(numel(cipherBytes), seed);

    % XOR again to recover original bytes
    outputBytes = bitxor(cipherBytes, keystream);

end