
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
        
        cipher update(ciphertext) .. cipher final
    )
    
    deriveKey := method(password, salt, keyLength,
        OpenSSL PBKDF2 derive(
            password, 
            salt, 
            10000,  # iterations
            keyLength,
            "sha256"
        )
    )
)

FileEncryptor := Object clone do(
    encryptFile := method(inputPath, outputPath, password,
        data := File with(inputPath) openForReading contents
        encrypted := AES encrypt(data, password)
        File with(outputPath) openForWriting write(encrypted) close
        "File encrypted successfully" println
    )
    
    decryptFile := method(inputPath, outputPath, password,
        encrypted := File with(inputPath) openForReading contents
        decrypted := AES decrypt(encrypted, password)
        File with(outputPath) openForWriting write(decrypted) close
        "File decrypted successfully" println
    )
)

# Example usage (commented out):
# FileEncryptor encryptFile("plain.txt", "encrypted.bin", "secret123")
# FileEncryptor decryptFile("encrypted.bin", "decrypted.txt", "secret123")