
OpenSSL do(
    // Generate random initialization vector
    randomIV := method(size,
        File with("/dev/urandom") openForReading readBufferOfLength(size)
    )

    // Encrypt data using AES-256-CBC
    encrypt := method(data, key,
        iv := randomIV(16)
        cipher := OpenSSL Cipher get("aes-256-cbc")
        cipher encryptInit(key, iv)
        encrypted := cipher update(data) .. cipher final
        iv .. encrypted
    )

    // Decrypt data using AES-256-CBC
    decrypt := method(encryptedData, key,
        iv := encryptedData slice(0, 16)
        data := encryptedData slice(16)
        cipher := OpenSSL Cipher get("aes-256-cbc")
        cipher decryptInit(key, iv)
        cipher update(data) .. cipher final
    )
)

// Example usage (commented out in actual utility)
/*
key := "32_byte_key_for_aes_256_encryption!!"
data := "Sensitive information to protect"
encrypted := OpenSSL encrypt(data, key)
decrypted := OpenSSL decrypt(encrypted, key)
decrypted println // Should output original data
*/
AES := Object clone do(
    encrypt := method(data, key,
        iv := Random bytes(16)
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setEncryptKey(key) setIV(iv)
        encrypted := cipher update(data) .. cipher final
        iv .. encrypted
    )

    decrypt := method(data, key,
        iv := data slice(0, 16)
        ciphertext := data slice(16)
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setDecryptKey(key) setIV(iv)
        cipher update(ciphertext) .. cipher final
    )
)

// Example usage (commented out in actual file):
// key := "32_byte_key_for_aes_256_cbc_encryption"
// original := "Secret data to protect"
// encrypted := AES encrypt(original, key)
// decrypted := AES decrypt(encrypted, key)
// decrypted println // Should print: Secret data to protect
AES := Object clone do(
    encrypt := method(data, key,
        iv := Random bytes(16)
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setEncryptKey(key) setIV(iv)
        encrypted := cipher update(data) .. cipher final
        iv .. encrypted
    )
    
    decrypt := method(data, key,
        iv := data slice(0, 16)
        ciphertext := data slice(16)
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setDecryptKey(key) setIV(iv)
        cipher update(ciphertext) .. cipher final
    )
)

File encryptToFile := method(outputPath, key,
    encrypted := AES encrypt(self contents, key)
    File with(outputPath) open write(encrypted) close
)

File decryptFromFile := method(inputPath, key,
    encrypted := File with(inputPath) open readToEnd
    AES decrypt(encrypted, key)
)

if(isLaunchScript,
    args := System args
    if(args size < 4,
        "Usage: #{args at(0)} <encrypt|decrypt> <input> <output> <key>" interpolate println
        return
    )
    
    action := args at(1)
    input := args at(2)
    output := args at(3)
    key := args at(4)
    
    if(action == "encrypt",
        File with(input) encryptToFile(output, key)
        "Encrypted #{input} to #{output}" interpolate println
    ) elseif(action == "decrypt",
        result := File decryptFromFile(input, key)
        File with(output) open write(result) close
        "Decrypted #{input} to #{output}" interpolate println
    )
)