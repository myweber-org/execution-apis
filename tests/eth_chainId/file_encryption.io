
OpenSSL := Object clone do(
    encrypt := method(data, password,
        cipher := "aes-256-cbc"
        salt := OpenSSL randomBytes(8)
        keyIv := OpenSSL EVP_BytesToKey(
            cipher,
            OpenSSL EVP_md5,
            salt,
            password,
            1,
            32,
            16
        )
        
        enc := OpenSSL Cipher new(cipher) encrypt
        enc setKey(keyIv slice(0, 32))
        enc setIv(keyIv slice(32, 48))
        encrypted := enc update(data) .. enc final
        
        "Salted__" .. salt .. encrypted
    )
    
    decrypt := method(data, password,
        if(data beginsWith("Salted__") not, 
            return "Invalid format: missing salt header"
        )
        
        salt := data slice(8, 16)
        ciphertext := data slice(16)
        cipher := "aes-256-cbc"
        
        keyIv := OpenSSL EVP_BytesToKey(
            cipher,
            OpenSSL EVP_md5,
            salt,
            password,
            1,
            32,
            16
        )
        
        dec := OpenSSL Cipher new(cipher) decrypt
        dec setKey(keyIv slice(0, 32))
        dec setIv(keyIv slice(32, 48))
        
        decrypted := dec update(ciphertext) .. dec final
        decrypted
    )
    
    randomBytes := method(count,
        File standardInput readBuffer(count)
    )
)

FileEncryption := Object clone do(
    encryptFile := method(inputPath, outputPath, password,
        data := File with(inputPath) openForReading readBuffer(File with(inputPath) size)
        encrypted := OpenSSL encrypt(data, password)
        File with(outputPath) openForUpdating write(encrypted) close
        "Encrypted #{inputPath} -> #{outputPath}" interpolate
    )
    
    decryptFile := method(inputPath, outputPath, password,
        data := File with(inputPath) openForReading readBuffer(File with(inputPath) size)
        decrypted := OpenSSL decrypt(data, password)
        if(decrypted beginsWith("Invalid format"), return decrypted)
        File with(outputPath) openForUpdating write(decrypted) close
        "Decrypted #{inputPath} -> #{outputPath}" interpolate
    )
)