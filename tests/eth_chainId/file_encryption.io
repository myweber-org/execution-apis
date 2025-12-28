
AESEncryption := Object clone do(
    encrypt := method(data, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        cipher := OpenSSLCipher clone setCipher("aes-256-cbc") setKey(key) setIV(iv)
        encrypted := cipher encrypt(data)
        
        result := Sequence clone
        result appendSeq(salt)
        result appendSeq(iv)
        result appendSeq(encrypted)
        result asBase64
    )
    
    decrypt := method(encryptedData, password,
        data := encryptedData fromBase64
        salt := data slice(0, 16)
        iv := data slice(16, 32)
        ciphertext := data slice(32)
        
        key := self deriveKey(password, salt, 32)
        
        cipher := OpenSSLCipher clone setCipher("aes-256-cbc") setKey(key) setIV(iv)
        cipher decrypt(ciphertext)
    )
    
    deriveKey := method(password, salt, keyLength,
        OpenSSLKDF pbkdf2_hmac_sha1(password, salt, 10000, keyLength)
    )
)

File encryptToFile := method(outputPath, password,
    content := self read
    encrypted := AESEncryption encrypt(content, password)
    File with(outputPath) openForUpdating write(encrypted) close
    self
)

File decryptFromFile := method(password,
    encrypted := self read
    AESEncryption decrypt(encrypted, password)
)

if(isLaunchScript,
    if(System args size == 4,
        action := System args at(1)
        inputFile := System args at(2)
        outputFile := System args at(3)
        password := System args at(4)
        
        if(action == "encrypt",
            File with(inputFile) encryptToFile(outputFile, password)
            "File encrypted successfully" println
        ) elseif(action == "decrypt",
            decrypted := File with(inputFile) decryptFromFile(password)
            File with(outputFile) openForUpdating write(decrypted) close
            "File decrypted successfully" println
        ) else(
            "Usage: io file_encryption.io <encrypt|decrypt> <input> <output> <password>" println
        )
    ) else(
        "Usage: io file_encryption.io <encrypt|decrypt> <input> <output> <password>" println
    )
)