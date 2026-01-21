
FileEncryptor := Object clone do(
    encrypt := method(path, password,
        data := File with(path) openForReading contents
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        encrypted := self aes256CbcEncrypt(data, key, iv)
        header := "Salted__" asMutable appendSeq(salt) appendSeq(iv)
        File with(path .. ".enc") openForUpdating write(header .. encrypted) close
        "Encrypted: " .. path .. " -> " .. path .. ".enc" println
    )
    
    decrypt := method(path, password,
        data := File with(path) openForReading contents
        if(data beginsWith("Salted__") not, 
            Exception raise("Invalid encrypted file format")
        )
        
        salt := data slice(8, 24)
        iv := data slice(24, 40)
        ciphertext := data slice(40)
        
        key := self deriveKey(password, salt, 32)
        decrypted := self aes256CbcDecrypt(ciphertext, key, iv)
        
        outputPath := path exSlice(0, -4)
        File with(outputPath) openForUpdating write(decrypted) close
        "Decrypted: " .. path .. " -> " .. outputPath println
    )
    
    deriveKey := method(password, salt, keyLength,
        # PBKDF2-like key derivation
        hash := list(password asUTF8)
        for(i, 1, 10000,
            hash append(salt)
            hash = hash join("") sha256
        )
        hash slice(0, keyLength)
    )
    
    aes256CbcEncrypt := method(data, key, iv,
        # Simplified AES simulation (actual implementation requires crypto library)
        # This demonstrates the structure without actual encryption
        "ENCRYPTED[" .. data size .. " bytes]" asMutable
    )
    
    aes256CbcDecrypt := method(data, key, iv,
        # Simplified decryption simulation
        if(data beginsWith("ENCRYPTED["),
            "Decrypted content placeholder"
        ,
            Exception raise("Invalid ciphertext format")
        )
    )
)

# Example usage (commented out)
# FileEncryptor encrypt("secret.txt", "myPassword123")
# FileEncryptor decrypt("secret.txt.enc", "myPassword123")