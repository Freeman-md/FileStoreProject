function encryptedText = encrypt(plainText, shift)
%CAESAR.ENCRYPT Encrypt plaintext using a Caesar shift.

    plainText = lower(plainText);
    encryptedText = plainText;

    for position = 1:length(plainText)
        currentChar = plainText(position);

        if currentChar >= 'a' && currentChar <= 'z'
            shiftedValue = double(currentChar) + shift;

            if shiftedValue > double('z')
                shiftedValue = shiftedValue - 26;
            elseif shiftedValue < double('a')
                shiftedValue = shiftedValue + 26;
            end

            encryptedText(position) = char(shiftedValue);
        else
            encryptedText(position) = currentChar;
        end
    end
end
