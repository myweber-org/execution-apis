
AES := Object clone do(
    encrypt := method(data, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setKey(key)
        cipher setIV(iv)
        cipher encryptInit
        
        encrypted := cipher update(data) .. cipher final
        result := salt .. iv .. encrypted
        Base64 encode(result)
    )
    
    decrypt := method(encryptedData, password,
        data := Base64 decode(encryptedData)
        salt := data slice(0, 16)
        iv := data slice(16, 32)
        ciphertext := data slice(32)
        
        key := self deriveKey(password, salt, 32)
        
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setKey(key)
        cipher setIV(iv)
        cipher decryptInit
        
        decrypted := cipher update(ciphertext) .. cipher final
        decrypted
    )
    
    deriveKey := method(password, salt, keyLength,
        OpenSSL EVP BytesToKey with("sha256") \
            derive(password, salt, 10000, keyLength)
    )
)

FileEncryptor := Object clone do(
    encryptFile := method(inputPath, outputPath, password,
        data := File with(inputPath) openForReading contents
        encrypted := AES encrypt(data, password)
        File with(outputPath) openForUpdating write(encrypted) close
        "File encrypted successfully" println
    )
    
    decryptFile := method(inputPath, outputPath, password,
        encrypted := File with(inputPath) openForReading contents
        decrypted := AES decrypt(encrypted, password)
        File with(outputPath) openForUpdating write(decrypted) close
        "File decrypted successfully" println
    )
)