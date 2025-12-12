function writeBinaryFile(filepath, data)
    fid = fopen(filepath, 'wb');
    if fid == -1
        error('Failed to open file: %s', filepath);
    end
    fwrite(fid, data, 'uint8');
    fclose(fid);
end
