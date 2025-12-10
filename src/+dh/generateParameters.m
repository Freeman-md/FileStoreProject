function [p, g] = generateParameters()
%GENERATEPARAMETERS Returns prime p and generator g for DH key exchange.

    p = 23;   % small demo prime
    g = 5;    % primitive root modulo p
end
