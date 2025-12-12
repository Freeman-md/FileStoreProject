function data = readBinaryFile(filepath)
    fid = fopen(filepath, 'rb');
    if fid == -1
        error('Failed to open file: %s', filepath);
    end
    data = fread(fid, Inf, 'uint8=>uint8')';
    fclose(fid);
end
