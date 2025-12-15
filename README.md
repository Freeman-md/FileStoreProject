# Secure File Store – CST4136

This project is a MATLAB-based **Secure File Store** developed for the module **CST4136 – Cybersecurity & Cloud Systems**.

It demonstrates the implementation of core cryptographic concepts through clean, modular code, supported by unit tests and an interactive menu-driven interface.

## 📌 Features Overview

The project implements the following cryptographic components:

### Classic Cryptography
- **Caesar Cipher**
  - Text-only encryption and decryption
  - Preserves non-letter characters
  - Fully tested

### Symmetric Cryptography
- **One-Time Pad (OTP)**
  - Text-based OTP using random keys
  - XOR-based encryption and decryption
- **XOR Stream Cipher**
  - PRNG-based keystream (seeded)
  - Supports text and binary data (files, images)

### Block Cipher
- **AES-128**
  - Full AES implementation from scratch
  - Supported modes:
    - ECB (with PKCS#7 padding)
    - CBC (with random IV + PKCS#7 padding)
  - Works on text and binary data

### Hashing & Integrity
- **Simple Hash**
  - Toy checksum-style hash (educational)
- **SHA-256**
  - Text-only wrapper using Java MessageDigest
- **HMAC-SHA256**
  - Proper HMAC construction with ipad/opad
  - RFC test vectors included

### Asymmetric Cryptography
- **RSA**
  - Key generation, encryption, decryption
  - Text-only (demo-sized keys)
- **Diffie–Hellman**
  - Key exchange with shared secret agreement

### Hybrid Cryptography
- **Envelope Encryption**
  - AES-CBC for data encryption
  - RSA used to wrap the AES key
  - Demonstrates real-world hybrid encryption design

### Key Management
- AES key generation, save/load
- RSA key save/load
- Diffie–Hellman key save/load
- Password-based key derivation (PBKDF2-style)

## 🗂 Project Structure

```text
.
├── src/
│   ├── main.m                  # Menu-driven entry point
│   ├── +aes/                   # AES-128 implementation
│   ├── +caesar/                # Caesar cipher
│   ├── +otp/                   # One-Time Pad
│   ├── +xorstream/             # XOR stream cipher
│   ├── +hash/                  # Hashing & HMAC
│   ├── +rsa/                   # RSA cryptography
│   ├── +dh/                    # Diffie–Hellman
│   ├── +envelope/              # Envelope encryption
│   ├── +keymgmt/               # Key management utilities
│   └── utils/                  # Binary file helpers
│
├── tests/                      # Unit tests (MATLAB functiontests)
├── data/                       # Sample text, binary, and image files
├── docs/
│   └── dev_notes.txt           # Development log
```

## ▶️ How to Run

1. Open MATLAB.
2. Set the project root as the working directory.
3. Run:
   ```matlab
   main
   ```
4. Use the menu to select cryptographic operations.

## 🧪 Testing

All modules are covered by unit tests.

To run all tests:

```matlab
runtests
```

Tests include:

* Known AES test vectors (NIST)
* Round-trip encryption and decryption
* Padding behaviour
* Randomness checks
* Key save and load verification

## ⚠️ Notes & Limitations

* RSA and Diffie–Hellman use small parameters for demonstration only.
* This project is educational and not intended for production use.
* AES-GCM is discussed conceptually; AES-CBC is implemented for clarity.

## 📚 References

* [Mihailescu, M. I., & Nita, S. L. *Cryptography and Cryptanalysis in MATLAB*. O’Reilly.](https://www.oreilly.com/library/view/cryptography-and-cryptanalysis/9781484273340/)
* MATLAB Documentation
* CST4136 Lecture and Lab Materials

## 👤 Author

**Freeman Madudili**
MSc Computer Science
Middlesex University London
