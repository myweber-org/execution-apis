
AESEncryption := Object clone do(
    encrypt := method(data, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        cipher := OpenSSLCipher clone setCipher("aes-256-cbc") setKey(key) setIV(iv)
        encrypted := cipher encrypt(data)
        
        result := Sequence clone
        result appendSeq("Salted__")
        result appendSeq(salt)
        result appendSeq(iv)
        result appendSeq(encrypted)
        result asBase64
    )
    
    decrypt := method(encryptedData, password,
        data := encryptedData fromBase64
        if(data slice(0, 8) asString != "Salted__", 
            Exception raise("Invalid encrypted data format"))
        
        salt := data slice(8, 24)
        iv := data slice(24, 40)
        ciphertext := data slice(40)
        
        key := self deriveKey(password, salt, 32)
        
        cipher := OpenSSLCipher clone setCipher("aes-256-cbc") setKey(key) setIV(iv)
        cipher decrypt(ciphertext)
    )
    
    deriveKey := method(password, salt, keyLength,
        OpenSSLDigest pbkdf2(password, salt, 10000, keyLength, "sha256")
    )
)

File encryptFile := method(inputPath, outputPath, password,
    data := File with(inputPath) openForReading contents
    encrypted := AESEncryption encrypt(data, password)
    File with(outputPath) openForUpdating write(encrypted) close
)

File decryptFile := method(inputPath, outputPath, password,
    data := File with(inputPath) openForReading contents
    decrypted := AESEncryption decrypt(data, password)
    File with(outputPath) openForUpdating write(decrypted) close
)