
AES := Object clone do(
    encrypt := method(data, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setEncryptKey(key) setIV(iv)
        encrypted := cipher update(data) .. cipher final
        
        result := salt .. iv .. encrypted
        Base64 encode(result)
    )
    
    decrypt := method(encodedData, password,
        data := Base64 decode(encodedData)
        salt := data slice(0, 16)
        iv := data slice(16, 32)
        encrypted := data slice(32)
        
        key := self deriveKey(password, salt, 32)
        
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setDecryptKey(key) setIV(iv)
        decrypted := cipher update(encrypted) .. cipher final
        
        decrypted
    )
    
    deriveKey := method(password, salt, keyLength,
        OpenSSL PBKDF2 with(
            password,
            salt,
            10000,
            keyLength,
            "sha256"
        )
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
        data := File with(inputPath) openForReading contents
        decrypted := AES decrypt(data, password)
        File with(outputPath) openForUpdating write(decrypted) close
        "File decrypted successfully" println
    )
)

if(isLaunchScript,
    if(System args size == 4,
        action := System args at(1)
        inputFile := System args at(2)
        outputFile := System args at(3)
        password := System args at(4)
        
        if(action == "encrypt",
            FileEncryptor encryptFile(inputFile, outputFile, password)
        ) elseif(action == "decrypt",
            FileEncryptor decryptFile(inputFile, outputFile, password)
        ) else(
            "Usage: io file_encryption.io <encrypt|decrypt> <input> <output> <password>" println
        )
    ) else(
        "Usage: io file_encryption.io <encrypt|decrypt> <input> <output> <password>" println
    )
)