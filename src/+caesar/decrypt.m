function decryptedText = decrypt(cipherText, shift)
%CAESAR.DECRYPT Decrypt ciphertext using a Caesar shift.
%
%   decryptedText = caesar.decrypt(cipherText, shift)

    cipherText = lower(cipherText);
    decryptedText = cipherText;

    for position = 1:length(cipherText)
        currentChar = cipherText(position);

        if currentChar >= 'a' && currentChar <= 'z'
            shiftedValue = double(currentChar) - shift;

            if shiftedValue > double('z')
                shiftedValue = shiftedValue - 26;
            elseif shiftedValue < double('a')
                shiftedValue = shiftedValue + 26;
            end

            decryptedText(position) = char(shiftedValue);
        else
            decryptedText(position) = currentChar;
        end
    end
end
