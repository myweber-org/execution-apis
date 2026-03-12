
OpenSSL do(
    // Generate random initialization vector
    randomIV := method(size,
        File with("/dev/urandom") openForReading readBufferOfLength(size)
    )

    // Encrypt data with password
    encrypt := method(data, password,
        iv := randomIV(16)
        key := OpenSSL EVP_BytesToKey("AES-256-CBC", "MD5", iv, password, 1, 32, 16)
        ctx := OpenSSL EVP_CIPHER_CTX_new
        OpenSSL EVP_EncryptInit_ex(ctx, "AES-256-CBC", nil, key, iv)
        
        outLen := data size + 16
        out := Sequence clone setSize(outLen)
        OpenSSL EVP_EncryptUpdate(ctx, out, outLen, data, data size)
        totalLen := outLen
        OpenSSL EVP_EncryptFinal_ex(ctx, out slice(outLen), outLen)
        totalLen = totalLen + outLen
        
        OpenSSL EVP_CIPHER_CTX_free(ctx)
        iv appendSeq(out slice(0, totalLen))
    )

    // Decrypt data with password
    decrypt := method(encrypted, password,
        iv := encrypted slice(0, 16)
        data := encrypted slice(16)
        key := OpenSSL EVP_BytesToKey("AES-256-CBC", "MD5", iv, password, 1, 32, 16)
        ctx := OpenSSL EVP_CIPHER_CTX_new
        OpenSSL EVP_DecryptInit_ex(ctx, "AES-256-CBC", nil, key, iv)
        
        outLen := data size
        out := Sequence clone setSize(outLen)
        OpenSSL EVP_DecryptUpdate(ctx, out, outLen, data, data size)
        totalLen := outLen
        OpenSSL EVP_DecryptFinal_ex(ctx, out slice(outLen), outLen)
        totalLen = totalLen + outLen
        
        OpenSSL EVP_CIPHER_CTX_free(ctx)
        out slice(0, totalLen)
    )
)

// Example usage (commented out)
/*
plaintext := "Sensitive data here"
password := "secret_passphrase"

encrypted := OpenSSL encrypt(plaintext, password)
decrypted := OpenSSL decrypt(encrypted, password)

decrypted println // Should match original plaintext
*/