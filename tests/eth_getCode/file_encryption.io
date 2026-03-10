
FileEncryption := Object clone do(
    encrypt := method(path, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        data := File with(path) openForReading contents
        encrypted := self performEncryption(data, key, iv)
        
        outputPath := path .. ".enc"
        File with(outputPath) openForUpdating write(
            salt .. iv .. encrypted
        ) close
        
        outputPath
    )
    
    decrypt := method(path, password,
        data := File with(path) openForReading contents
        salt := data slice(0, 16)
        iv := data slice(16, 32)
        encrypted := data slice(32)
        
        key := self deriveKey(password, salt, 32)
        decrypted := self performDecryption(encrypted, key, iv)
        
        outputPath := path exSlice(0, -4)
        File with(outputPath) openForUpdating write(decrypted) close
        
        outputPath
    )
    
    deriveKey := method(password, salt, keyLength,
        iterations := 100000
        digest := MD5
        key := List clone
        
        block := 1
        while(key size < keyLength,
            hmac := HMAC with(password) asBytes
            hmac update(salt)
            hmac update(block asBinary)
            
            u := hmac digest
            result := u
            
            for(i, 1, iterations - 1,
                hmac := HMAC with(password) asBytes
                hmac update(u)
                u := hmac digest
                result = result xor(u)
            )
            
            key appendSeq(result)
            block = block + 1
        )
        
        key slice(0, keyLength)
    )
    
    performEncryption := method(data, key, iv,
        cipher := Cipher clone setAlgorithm("AES") setMode("CBC") setPadding(true)
        cipher setKey(key) setIV(iv)
        cipher encrypt(data)
    )
    
    performDecryption := method(data, key, iv,
        cipher := Cipher clone setAlgorithm("AES") setMode("CBC") setPadding(true)
        cipher setKey(key) setIV(iv)
        cipher decrypt(data)
    )
)

FileEncryptionTest := Object clone do(
    run := method(
        testFile := "test_data.txt"
        File with(testFile) openForUpdating write("Sensitive information here") close
        
        password := "secure_password_123"
        
        writeln("Original file created: ", testFile)
        
        encrypted := FileEncryption encrypt(testFile, password)
        writeln("Encrypted file: ", encrypted)
        
        decrypted := FileEncryption decrypt(encrypted, password)
        writeln("Decrypted file: ", decrypted)
        
        originalContent := File with(testFile) openForReading contents
        decryptedContent := File with(decrypted) openForReading contents
        
        if(originalContent == decryptedContent,
            writeln("Test passed: Encryption/decryption successful")
        ,
            writeln("Test failed: Content mismatch")
        )
        
        # Cleanup
        list(testFile, encrypted, decrypted) foreach(path,
            File with(path) remove ifError(writeln("Could not remove ", path))
        )
    )
)

if(isLaunchScript,
    FileEncryptionTest run
)
OpenSSL do(
    encrypt := method(data, password,
        salt := OpenSSL randomBytes(8)
        keyIV := OpenSSL EVP_BytesToKey(
            OpenSSL EVP_aes_256_cbc,
            OpenSSL EVP_sha256,
            salt,
            password,
            1,
            32,
            16
        )
        
        ctx := OpenSSL EVP_CIPHER_CTX_new
        OpenSSL EVP_EncryptInit_ex(ctx, OpenSSL EVP_aes_256_cbc, nil, keyIV slice(0, 32), keyIV slice(32, 48))
        
        out := List clone
        out append("Salted__")
        out append(salt)
        
        outLen := 0
        cipherText := OpenSSL EVP_CIPHER_CTX_newBuffer(data size + 32)
        OpenSSL EVP_EncryptUpdate(ctx, cipherText, outLen, data, data size)
        totalLen := outLen
        
        OpenSSL EVP_EncryptFinal_ex(ctx, cipherText slice(outLen), outLen)
        totalLen = totalLen + outLen
        
        out append(cipherText slice(0, totalLen))
        OpenSSL EVP_CIPHER_CTX_free(ctx)
        out join
    )
    
    decrypt := method(encryptedData, password,
        if(encryptedData beginsWith("Salted__") not,
            Exception raise("Invalid encrypted data format")
        )
        
        salt := encryptedData slice(8, 16)
        cipherText := encryptedData slice(16)
        
        keyIV := OpenSSL EVP_BytesToKey(
            OpenSSL EVP_aes_256_cbc,
            OpenSSL EVP_sha256,
            salt,
            password,
            1,
            32,
            16
        )
        
        ctx := OpenSSL EVP_CIPHER_CTX_new
        OpenSSL EVP_DecryptInit_ex(ctx, OpenSSL EVP_aes_256_cbc, nil, keyIV slice(0, 32), keyIV slice(32, 48))
        
        outLen := 0
        plainText := OpenSSL EVP_CIPHER_CTX_newBuffer(cipherText size)
        OpenSSL EVP_DecryptUpdate(ctx, plainText, outLen, cipherText, cipherText size)
        totalLen := outLen
        
        OpenSSL EVP_DecryptFinal_ex(ctx, plainText slice(outLen), outLen)
        totalLen = totalLen + outLen
        
        result := plainText slice(0, totalLen)
        OpenSSL EVP_CIPHER_CTX_free(ctx)
        result
    )
)

File encryptToFile := method(outputPath, password,
    content := self read
    encrypted := OpenSSL encrypt(content, password)
    File with(outputPath) openForUpdating write(encrypted) close
    self
)

File decryptFromFile := method(inputPath, password,
    encrypted := File with(inputPath) read
    OpenSSL decrypt(encrypted, password)
)