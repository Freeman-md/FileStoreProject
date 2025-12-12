function key = generateAESKey()
%GENERATEAESKEY Generate a secure random AES-128 key
%   Output:
%       key - 16-byte uint8 AES key
    
    key = uint8(randi([0 255], 1, 16));

end