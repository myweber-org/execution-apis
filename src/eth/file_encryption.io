
AESEncryption := Object clone do(
    encrypt := method(data, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        cipher := OpenSSLCipher clone setCipher("aes-256-cbc")
        cipher setEncryptKey(key) setIV(iv)
        encrypted := cipher update(data) .. cipher final
        
        result := Sequence with(salt, iv, encrypted)
        result asBase64
    )
    
    decrypt := method(encryptedData, password,
        data := encryptedData fromBase64
        salt := data slice(0, 16)
        iv := data slice(16, 32)
        ciphertext := data slice(32)
        
        key := self deriveKey(password, salt, 32)
        
        cipher := OpenSSLCipher clone setCipher("aes-256-cbc")
        cipher setDecryptKey(key) setIV(iv)
        decrypted := cipher update(ciphertext) .. cipher final
        
        decrypted
    )
    
    deriveKey := method(password, salt, keyLength,
        iterations := 100000
        OpenSSL pbkdf2(password, salt, iterations, keyLength, "sha256")
    )
)

File safeWrite := method(path, data, password,
    encrypted := AESEncryption encrypt(data, password)
    File with(path) openForUpdating write(encrypted) close
)

File safeRead := method(path, password,
    encrypted := File with(path) openForReading contents
    AESEncryption decrypt(encrypted, password)
)

// Example usage (commented out in actual utility):
// File safeWrite("secret.txt", "Confidential data", "strongPassword")
// recovered := File safeRead("secret.txt", "strongPassword")
// recovered println