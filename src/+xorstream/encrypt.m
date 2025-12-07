function cipherBytes = encrypt(inputData, seed)
%XORSTREAM.ENCRYPT Encrypt text or binary using PRNG-based XOR stream cipher.

    if ischar(inputData)
        plainBytes = uint8(inputData);
    elseif isa(inputBytes, 'uint8')
        plainBytes = inputData(:)'; % ensure row vector
    else 
        error('xorstreamEncrypt:InvalidInputType', ...
            'Input must be char or uint8.');
    end


    % Generate keystream of matching length
    keystream = xorstream.generateKeystream(numel(plainBytes), seed)

    % XOR to encrypt
    cipherBytes = bitxor(plainBytes, keystream);
end
