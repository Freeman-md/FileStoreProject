function key = generateKey(n)
    keyStream = RandStream('mt19937ar', 'Seed', 'shuffle');

    key = randi(keyStream, [0, 255], 1, n, 'uint8');
end