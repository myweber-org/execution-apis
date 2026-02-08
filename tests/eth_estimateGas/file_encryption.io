
AESEncryption := Object clone do(
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
        cipher update(encrypted) .. cipher final
    )
    
    deriveKey := method(password, salt, keyLength,
        OpenSSL PBKDF2 derive(
            password, 
            salt, 
            100000,  # iterations
            keyLength,
            "sha256"
        )
    )
)

# Example usage (commented out in actual file):
# encrypted := AESEncryption encrypt("Secret message", "myPassword")
# decrypted := AESEncryption decrypt(encrypted, "myPassword")
# decrypted println