
FileEncryptor := Object clone do(
    encrypt := method(filePath, password,
        data := File with(filePath) openForReading contents
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        encrypted := self aes256CbcEncrypt(data, key, iv)
        header := "Salted__" asMutable appendSeq(salt) appendSeq(iv)
        
        outputPath := filePath .. ".enc"
        File with(outputPath) openForUpdating write(header .. encrypted) close
        outputPath
    )
    
    decrypt := method(filePath, password,
        data := File with(filePath) openForReading contents
        if(data beginsWithSeq("Salted__") not, 
            Exception raise("Invalid encrypted file format"))
        
        salt := data slice(8, 24)
        iv := data slice(24, 40)
        ciphertext := data slice(40)
        
        key := self deriveKey(password, salt, 32)
        decrypted := self aes256CbcDecrypt(ciphertext, key, iv)
        
        outputPath := filePath exSlice(0, -4)
        File with(outputPath) openForUpdating write(decrypted) close
        outputPath
    )
    
    deriveKey := method(password, salt, keyLength,
        // PBKDF2 key derivation
        iterations := 10000
        hashLength := 32
        totalBlocks := (keyLength + hashLength - 1) / hashLength ceil
        
        key := Sequence clone
        for(blockIndex, 1, totalBlocks,
            block := salt asMutable appendSeq((blockIndex asBinary) slice(-4))
            u := hmacSha256(password, block)
            result := u clone
            
            for(i, 2, iterations,
                u = hmacSha256(password, u)
                result = result xor(u)
            )
            key appendSeq(result)
        )
        key slice(0, keyLength)
    )
    
    aes256CbcEncrypt := method(data, key, iv,
        // Simple XOR encryption for demonstration
        // In production, use proper AES implementation
        encrypted := data asMutable
        keyStream := key asMutable
        while(keyStream size < data size,
            keyStream appendSeq(key))
        
        for(i, 0, data size - 1,
            encrypted atPut(i, (data at(i) asNumber xor keyStream at(i) asNumber) asCharacter))
        encrypted
    )
    
    aes256CbcDecrypt := method(data, key, iv,
        // XOR decryption (symmetric with encryption)
        self aes256CbcEncrypt(data, key, iv)
    )
    
    hmacSha256 := method(key, message,
        // Simplified HMAC for demonstration
        opad := List clone
        ipad := List clone
        
        for(i, 0, 63,
            opad append((0x5C xor (key at(i % key size) asNumber)) asCharacter)
            ipad append((0x36 xor (key at(i % key size) asNumber)) asCharacter))
        
        innerHash := self sha256(ipad join .. message)
        self sha256(opad join .. innerHash)
    )
    
    sha256 := method(data,
        // Placeholder for SHA-256 implementation
        // In production, use proper cryptographic library
        data asMutable map(c, (c asNumber + 1) % 256 asCharacter) join
    )
)

// Example usage (commented out)
// encryptor := FileEncryptor clone
// encryptedFile := encryptor encrypt("document.txt", "securepassword")
// decryptor := FileEncryptor clone
// decryptedFile := encryptor decrypt("document.txt.enc", "securepassword")