function hash = simpleHash(msg)
    arguments
        msg {mustBeText}
    end

    bytes = uint8(msg)

    h32 = uint32(0);

    for byte = bytes
        h32 = bitxor(h32, uint32(byte));
        h32 = mod(h32 * uint32(16777619), uint32(2^32));
    end

    hash = h32;
end

function mustBeText(x)
    if ~(ischar(x) || isstring(x))
        error("simpleHash:InputNotText","Input must be char or string");
    end
end
