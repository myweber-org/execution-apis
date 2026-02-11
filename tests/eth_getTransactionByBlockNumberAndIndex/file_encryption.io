
AES := Object clone do(
    encrypt := method(data, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setEncryptKey(key) setIV(iv)
        encrypted := cipher update(data) .. cipher final
        
        result := Sequence clone
        result appendSeq("Salted__")
        result appendSeq(salt)
        result appendSeq(iv)
        result appendSeq(encrypted)
        result asBase64
    )
    
    decrypt := method(encryptedBase64, password,
        data := encryptedBase64 asBase64 decoded
        if(data beginsWithSeq("Salted__") not, 
            Exception raise("Invalid encrypted format"))
        
        salt := data slice(8, 24)
        iv := data slice(24, 40)
        ciphertext := data slice(40)
        
        key := self deriveKey(password, salt, 32)
        
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setDecryptKey(key) setIV(iv)
        
        cipher update(ciphertext) .. cipher final
    )
    
    deriveKey := method(password, salt, keyLength,
        OpenSSL EVP BytesToKey(
            password, 
            salt, 
            "sha256", 
            1, 
            keyLength, 
            16
        )
    )
)

File encryptToFile := method(outputPath, password,
    encrypted := AES encrypt(self contents, password)
    File with(outputPath) open write(encrypted) close
    self
)

File decryptFromFile := method(inputPath, password,
    encrypted := File with(inputPath) open read contents
    AES decrypt(encrypted, password)
)