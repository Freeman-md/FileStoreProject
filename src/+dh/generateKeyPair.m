function [privateKey, publicKey] = generateKeyPair(p, g)
%GENERATEKEYPAIR Generate DH private/public keys.
%   privateKey in range [2, p-2]
%   publicKey = g^privateKey mod p

    privateKey = randi([2, p-2]);  
    publicKey  = rsa.modExp(g, privateKey, p);
end