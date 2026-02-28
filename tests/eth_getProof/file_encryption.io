
OpenSSL do(
    // Generate random IV
    iv := method(
        ctx := EVP_CIPHER_CTX_new
        EVP_CIPHER_CTX_reset(ctx)
        EVP_CIPHER_CTX_free(ctx)
        Random bytes(16)
    )

    // Encrypt data with password
    encrypt := method(data, password,
        key := EVP_BytesToKey(EVP_aes_256_cbc, EVP_sha256, nil, password asUTF8, password size, 32, 16)
        ivec := iv
        ctx := EVP_CIPHER_CTX_new
        EVP_EncryptInit_ex(ctx, EVP_aes_256_cbc, nil, key, ivec)
        
        out := List clone
        outBuffer := Buffer clone setSize(data size + 32)
        outLen := 0
        EVP_EncryptUpdate(ctx, outBuffer, outLen, data, data size)
        out append(outBuffer slice(0, outLen))
        
        finalLen := 0
        EVP_EncryptFinal_ex(ctx, outBuffer, finalLen)
        out append(outBuffer slice(0, finalLen))
        
        EVP_CIPHER_CTX_free(ctx)
        ivec .. out join
    )

    // Decrypt data with password
    decrypt := method(encrypted, password,
        ivec := encrypted slice(0, 16)
        ciphertext := encrypted slice(16)
        key := EVP_BytesToKey(EVP_aes_256_cbc, EVP_sha256, nil, password asUTF8, password size, 32, 16)
        
        ctx := EVP_CIPHER_CTX_new
        EVP_DecryptInit_ex(ctx, EVP_aes_256_cbc, nil, key, ivec)
        
        out := List clone
        outBuffer := Buffer clone setSize(ciphertext size + 32)
        outLen := 0
        EVP_DecryptUpdate(ctx, outBuffer, outLen, ciphertext, ciphertext size)
        out append(outBuffer slice(0, outLen))
        
        finalLen := 0
        EVP_DecryptFinal_ex(ctx, outBuffer, finalLen)
        out append(outBuffer slice(0, finalLen))
        
        EVP_CIPHER_CTX_free(ctx)
        out join
    )
)

// Example usage (commented out in actual utility)
/*
plaintext := "Sensitive data here"
password := "secret_passphrase"
encrypted := OpenSSL encrypt(plaintext, password)
decrypted := OpenSSL decrypt(encrypted, password)
decrypted println // Should match original plaintext
*/
OpenSSL do(
    // Generate random initialization vector
    randomIV := method(size,
        File with("/dev/urandom") openForReading readBufferOfLength(size)
    )

    // Encrypt data using AES-256-CBC
    encrypt := method(data, password,
        iv := randomIV(16)
        key := EVP_BytesToKey(EVP_aes_256_cbc, EVP_sha256, nil, password, 1, nil, nil)
        
        ctx := EVP_CIPHER_CTX_new
        EVP_EncryptInit_ex(ctx, EVP_aes_256_cbc, nil, key, iv)
        
        out := List clone
        out append(iv)
        
        buffer := Buffer clone
        EVP_EncryptUpdate(ctx, buffer, data)
        out append(buffer)
        
        finalBuffer := Buffer clone
        EVP_EncryptFinal_ex(ctx, finalBuffer)
        out append(finalBuffer)
        
        EVP_CIPHER_CTX_free(ctx)
        out join
    )

    // Decrypt data using AES-256-CBC
    decrypt := method(encryptedData, password,
        iv := encryptedData slice(0, 16)
        ciphertext := encryptedData slice(16)
        
        key := EVP_BytesToKey(EVP_aes_256_cbc, EVP_sha256, nil, password, 1, nil, nil)
        
        ctx := EVP_CIPHER_CTX_new
        EVP_DecryptInit_ex(ctx, EVP_aes_256_cbc, nil, key, iv)
        
        out := List clone
        buffer := Buffer clone
        EVP_DecryptUpdate(ctx, buffer, ciphertext)
        out append(buffer)
        
        finalBuffer := Buffer clone
        EVP_DecryptFinal_ex(ctx, finalBuffer)
        out append(finalBuffer)
        
        EVP_CIPHER_CTX_free(ctx)
        out join
    )
)

// Example usage (commented out in actual file)
/*
plaintext := "Sensitive data to encrypt"
password := "strong_password_here"

encrypted := OpenSSL encrypt(plaintext, password)
decrypted := OpenSSL decrypt(encrypted, password)

decrypted println // Should output: Sensitive data to encrypt
*/