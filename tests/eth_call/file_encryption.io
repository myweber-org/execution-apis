
AES := Object clone do(
    encrypt := method(data, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setEncryptKey(key) setIV(iv)
        encrypted := cipher update(data) .. cipher final
        
        header := "Salted__" .. salt
        header .. iv .. encrypted
    )
    
    decrypt := method(encryptedData, password,
        if(encryptedData beginsWith("Salted__") not,
            Exception raise("Invalid encrypted data format")
        )
        
        salt := encryptedData slice(8, 24)
        iv := encryptedData slice(24, 40)
        ciphertext := encryptedData slice(40)
        
        key := self deriveKey(password, salt, 32)
        
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setDecryptKey(key) setIV(iv)
        decrypted := cipher update(ciphertext) .. cipher final
        
        decrypted
    )
    
    deriveKey := method(password, salt, keyLength,
        iterations := 10000
        OpenSSL EVP BytesToKey with("sha256") derive(
            password, salt, iterations, keyLength
        )
    )
)

FileEncryptor := Object clone do(
    encryptFile := method(inputPath, outputPath, password,
        data := File with(inputPath) openForReading contents
        encrypted := AES encrypt(data, password)
        File with(outputPath) openForUpdating write(encrypted) close
        "Encrypted #{inputPath} to #{outputPath}" interpolate println
    )
    
    decryptFile := method(inputPath, outputPath, password,
        data := File with(inputPath) openForReading contents
        decrypted := AES decrypt(data, password)
        File with(outputPath) openForUpdating write(decrypted) close
        "Decrypted #{inputPath} to #{outputPath}" interpolate println
    )
)