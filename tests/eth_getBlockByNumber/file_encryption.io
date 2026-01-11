
AES := Object clone do(
    encrypt := method(data, key,
        iv := Random bytes(16)
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setEncryptKey(key) setIv(iv)
        encrypted := cipher update(data) .. cipher final
        iv .. encrypted
    )

    decrypt := method(data, key,
        iv := data slice(0, 16)
        ciphertext := data slice(16)
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setDecryptKey(key) setIv(iv)
        cipher update(ciphertext) .. cipher final
    )
)

// Example usage (commented out in actual file):
// key := "my-32-byte-encryption-key-1234567890ab"
// encrypted := AES encrypt("Secret message", key)
// decrypted := AES decrypt(encrypted, key)
// decrypted println