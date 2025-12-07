function keystream = generateKeystream(lengthBytes, seed)
%XORSTREAM.GENERATEKEYSTREAM Produce a repeatable PRNG-based keystream.

    if nargin < 2
         error('generateKeystream:MissingSeed', ...
              'A seed value must be provided for deterministic keystream.');
    end

    if lengthBytes <= 0
        keystream = uint8([]);
        return;
    end

    stream = RandStream('mt19937ar', 'Seed', seed);

    keystream = uint8(randi(stream), [0, 255], 1, lengthBytes);

end