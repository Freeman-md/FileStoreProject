function secret = computeSharedSecret(otherPublicKey, privateKey, p)
%COMPUTESHAREDSECRET Compute shared DH secret.
%   Uses: secret = otherPublicKey^privateKey mod p

    secret = rsa.modExp(otherPublicKey, privateKey, p);
end
