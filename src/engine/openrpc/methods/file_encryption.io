
OpenSSL do(
    // Generate random initialization vector
    randomIV := method(size,
        File with("/dev/urandom") openForReading readBufferOfLength(size)
    )

    // Encrypt data using AES-256-CBC
    encrypt := method(data, key,
        iv := randomIV(16)
        cipher := OpenSSL Cipher get("aes-256-cbc")
        cipher encryptInit(key, iv)
        encrypted := cipher update(data) .. cipher final
        iv .. encrypted
    )

    // Decrypt data using AES-256-CBC
    decrypt := method(encryptedData, key,
        iv := encryptedData slice(0, 16)
        data := encryptedData slice(16)
        cipher := OpenSSL Cipher get("aes-256-cbc")
        cipher decryptInit(key, iv)
        cipher update(data) .. cipher final
    )
)

// Example usage (commented out in actual utility)
/*
key := "32_byte_key_for_aes_256_encryption!!"
data := "Sensitive information to protect"
encrypted := OpenSSL encrypt(data, key)
decrypted := OpenSSL decrypt(encrypted, key)
decrypted println // Should output original data
*/