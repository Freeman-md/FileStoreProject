function key = loadAESKey(filepath)
%LOADAESKEY Load AES key from raw binary file
%   Input:
%       filepath - key file path
%   Output:
%       key - 16-byte uint8 AES key

    fid = fopen(filepath, 'rb');

    if fid == -1
        error('Failed to open key file');
    end

    key = fread(fid, Inf, 'uint8=>uint8')'; % force uint8 + row vector
    fclose(fid);

    if numel(key) ~= 16
        error('Invalid AES key length: expected 16 bytes');
    end
end