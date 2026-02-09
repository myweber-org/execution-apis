
FileEncryptor := Object clone do(
    encrypt := method(data, password,
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        cipher := Cipher clone setAlgorithm("AES-256-CBC") setKey(key) setIV(iv)
        encrypted := cipher encrypt(data)
        
        result := salt .. iv .. encrypted
        Base64 encode(result)
    )
    
    decrypt := method(encodedData, password,
        data := Base64 decode(encodedData)
        salt := data slice(0, 16)
        iv := data slice(16, 32)
        encrypted := data slice(32)
        
        key := self deriveKey(password, salt, 32)
        cipher := Cipher clone setAlgorithm("AES-256-CBC") setKey(key) setIV(iv)
        
        cipher decrypt(encrypted)
    )
    
    deriveKey := method(password, salt, keyLength,
        iterations := 10000
        Digest pbkdf2("SHA256", password, salt, iterations, keyLength)
    )
)

if(isLaunchScript,
    if(System args size == 4,
        action := System args at(1)
        inputFile := System args at(2)
        outputFile := System args at(3)
        password := File standardInput readLine strip
        
        if(action == "encrypt",
            data := File with(inputFile) openForReading read
            encrypted := FileEncryptor encrypt(data, password)
            File with(outputFile) openForUpdating write(encrypted)
            "File encrypted successfully" println
        ,
        action == "decrypt",
            data := File with(inputFile) openForReading read
            decrypted := FileEncryptor decrypt(data, password)
            File with(outputFile) openForUpdating write(decrypted)
            "File decrypted successfully" println
        ,
            "Usage: io file_encryptor.io <encrypt|decrypt> <input> <output>" println
        )
    ,
        "Usage: io file_encryptor.io <encrypt|decrypt> <input> <output>" println
    )
)