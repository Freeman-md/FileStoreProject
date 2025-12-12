function saveAESKey(key, filepath)
%SAVEAESKEY Save AES key as raw binary
%   Inputs:
%       key      - uint8 AES key (16 bytes)
%       filepath - output file path

    if ~isa(key, 'uint8') || numel(key) ~= 16
        error('AES key must be a 16-byte uint8 array');
    end

    fid = fopen(filepath, 'wb');
    if fid == -1
        error('Failed to open file for writing: %s', filepath);
    end

    fwrite(fid, key, 'uint8');
    fclose(fid);

end
