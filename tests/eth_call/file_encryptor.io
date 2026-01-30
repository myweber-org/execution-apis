
FileEncryptor := Object clone do(
    encrypt := method(inputFile, outputFile, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        data := File with(inputFile) openForReading contents
        encrypted := self aesEncrypt(data, key, iv)
        
        File with(outputFile) openForUpdating write(
            salt .. iv .. encrypted
        ) close
        
        "Encrypted #{inputFile} to #{outputFile}" println
    )
    
    decrypt := method(inputFile, outputFile, password,
        content := File with(inputFile) openForReading contents
        salt := content slice(0, 16)
        iv := content slice(16, 32)
        encrypted := content slice(32)
        
        key := self deriveKey(password, salt, 32)
        decrypted := self aesDecrypt(encrypted, key, iv)
        
        File with(outputFile) openForUpdating write(decrypted) close
        
        "Decrypted #{inputFile} to #{outputFile}" println
    )
    
    deriveKey := method(password, salt, keyLength,
        iterations := 100000
        Digest PBKDF2 sha256(password, salt, iterations, keyLength)
    )
    
    aesEncrypt := method(data, key, iv,
        cipher := Cipher clone setAlgorithm("AES-256-CBC") setKey(key) setIV(iv)
        cipher encrypt(data)
    )
    
    aesDecrypt := method(data, key, iv,
        cipher := Cipher clone setAlgorithm("AES-256-CBC") setKey(key) setIV(iv)
        cipher decrypt(data)
    )
)

if(isLaunchScript,
    args := System args
    if(args size == 4,
        action := args at(1)
        inputFile := args at(2)
        outputFile := args at(3)
        password := args at(4)
        
        if(action == "encrypt",
            FileEncryptor encrypt(inputFile, outputFile, password)
        ) elseif(action == "decrypt",
            FileEncryptor decrypt(inputFile, outputFile, password)
        ) else(
            "Usage: io file_encryptor.io [encrypt|decrypt] input output password" println
        )
    ) else(
        "Usage: io file_encryptor.io [encrypt|decrypt] input output password" println
    )
)