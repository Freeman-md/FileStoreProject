function inv = modInverse(a, m)
%MODINVERSE Compute modular inverse using Extended Euclidean Algorithm
%   Returns x such that (a*x) mod m = 1.
%   If no inverse exists, returns [].

    a = mod(a, m);

    % Extended Euclidean Algorithm
    t = 0;  
    newT = 1;
    r = m; 
    newR = a;

    while newR ~= 0
        q = floor(r / newR);
        
        temp = newT;
        newT = t - q * newT;
        t = temp;

        temp = newR;
        newR = r - q * newR;
        r = temp;
    end

    % If gcd(a, m) ≠ 1, inverse does not exist
    if r ~= 1
        inv = [];
        return;
    end

    % Ensure positive result
    if t < 0
        t = t + m;
    end

    inv = t;
end
