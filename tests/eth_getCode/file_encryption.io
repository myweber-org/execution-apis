
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