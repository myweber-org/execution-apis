
FileEncryptor := Object clone do(
    encrypt := method(filePath, password,
        key := password asSha256
        iv := Random bytes(16)
        
        data := File with(filePath) openForReading contents
        encrypted := data encryptAesCbc(key, iv)
        
        outputPath := filePath .. ".enc"
        File with(outputPath) openForUpdating write(iv .. encrypted)
        "Encrypted file saved to: #{outputPath}" interpolate println
    )
    
    decrypt := method(filePath, password,
        key := password asSha256
        data := File with(filePath) openForReading contents
        
        iv := data slice(0, 16)
        encrypted := data slice(16)
        
        decrypted := encrypted decryptAesCbc(key, iv)
        
        outputPath := filePath exSlice(0, -4)
        File with(outputPath) openForUpdating write(decrypted)
        "Decrypted file saved to: #{outputPath}" interpolate println
    )
)

if(isLaunchScript,
    args := System args
    if(args size < 4,
        "Usage: #{args at(0)} [encrypt|decrypt] file password" interpolate println
        return
    )
    
    action := args at(1)
    targetFile := args at(2)
    pass := args at(3)
    
    if(action == "encrypt",
        FileEncryptor encrypt(targetFile, pass)
    ) elseif(action == "decrypt",
        FileEncryptor decrypt(targetFile, pass)
    ) else(
        "Invalid action. Use 'encrypt' or 'decrypt'" println
    )
)