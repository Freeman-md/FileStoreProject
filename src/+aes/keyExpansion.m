function roundKeys = keyExpansion(initialKeyBytes)
%AES.KEYEXPANSION Generate AES-128 round keys (176 bytes total).

    % AES-128 parameters
    Nk = 4;          % words in key
    Nb = 4;          % words in block
    Nr = 10;         % number of rounds
    totalWords = Nb * (Nr + 1);

    % Ensure key is uint8 row vector length 16
    if ~isa(initialKeyBytes, 'uint8') || numel(initialKeyBytes) ~= 16
        error('keyExpansion:InvalidKey', ...
              'AES-128 key must be 16 bytes (uint8).');
    end

    % Convert key bytes -> 4-byte words
    roundKeys = zeros(4, totalWords, 'uint8');
    roundKeys(:, 1:Nk) = reshape(initialKeyBytes, 4, []);

    rconValues = uint8([1 2 4 8 16 32 64 128 27 54]); % AES Rcon for 10 rounds

    for wordIndex = Nk : (totalWords - 1)
        tempWord = roundKeys(:, wordIndex);

        if mod(wordIndex, Nk) == 0
            tempWord = subWord(rotWord(tempWord));
            tempWord(1) = bitxor(tempWord(1), rconValues(wordIndex / Nk));
        end

        roundKeys(:, wordIndex + 1) = bitxor(roundKeys(:, wordIndex - Nk + 1), tempWord);
    end
end


% Helper functions
function out = rotWord(word)
    out = circshift(word, -1);
end

function out = subWord(word)
    out = uint8(arrayfun(@aes_sbox, word));
end

function val = aes_sbox(byte)
    % AES S-Box table (256-byte lookup)
    persistent S
    if isempty(S)
        S = uint8([
        99 124 119 123 242 107 111 197  48   1 103  43 254 215 171 118 ...
        202 130 201 125 250  89  71 240 173 212 162 175 156 164 114 192 ...
        183 253 147  38  54  63 247 204  52 165 229 241 113 216  49  21 ...
          4 199  35 195  24 150   5 154   7  18 128 226 235  39 178 117 ...
          9 131  44  26  27 110  90 160  82  59 214 179  41 227  47 132 ...
        83 209   0 237  32 252 177  91 106 203 190  57  74  76  88 207 ...
        208 239 170 251  67  77  51 133  69 249   2 127  80  60 159 168 ...
         81 163  64 143 146 157  56 245 188 182 218  33  16 255 243 210 ...
        205  12  19 236  95 151  68  23 196 167 126  61 100  93  25 115 ...
         96 129  79 220  34  42 144 136  70 238 184  20 222  94  11 219 ...
        224  50  58  10  73   6  36  92 194 211 172  98 145 149 228 121 ...
        231 200  55 109 141 213  78 169 108  86 244 234 101 122 174   8 ...
        186 120  37  46  28 166 180 198 232 221 116  31  75 189 139 138 ...
        112  62 181 102  72   3 246  14  97  53  87 185 134 193  29 158 ...
        225 248 152  17 105 217 142 148 155  30 135 233 206  85  40 223 ...
        140 161 137  13 191 230  66 104  65 153  45  15 176  84 187  22]);
    end

    val = S(double(byte) + 1);
end
