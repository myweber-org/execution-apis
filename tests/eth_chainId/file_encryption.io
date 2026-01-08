
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
OpenSSL do(
    // Generate random IV
    iv := method(
        OpenSSL Random bytes(16)
    )

    // Pad data to block size
    pad := method(data,
        blockSize := 16
        padding := blockSize - (data size % blockSize)
        data .. (String with(padding asCharacter) repeated(padding))
    )

    // Unpad data after decryption
    unpad := method(data,
        padding := data at(data size - 1)
        data exSlice(0, data size - padding)
    )

    // Encrypt with AES-256-CBC
    encrypt := method(key, plaintext,
        cipher := OpenSSL Cipher with("aes-256-cbc")
        ivBytes := iv
        cipher encryptInit(key, ivBytes)
        padded := pad(plaintext)
        encrypted := cipher update(padded) .. cipher final
        ivBytes .. encrypted
    )

    // Decrypt AES-256-CBC
    decrypt := method(key, ciphertext,
        cipher := OpenSSL Cipher with("aes-256-cbc")
        ivBytes := ciphertext exSlice(0, 16)
        data := ciphertext exSlice(16)
        cipher decryptInit(key, ivBytes)
        decrypted := cipher update(data) .. cipher final
        unpad(decrypted)
    )
)

// Example usage (commented out in actual utility)
/*
key := "32_byte_key_for_aes_256_cbc_encryption"
data := "Sensitive information to protect"
encrypted := OpenSSL encrypt(key, data)
decrypted := OpenSSL decrypt(key, encrypted)
decrypted println // Should match original data
*/