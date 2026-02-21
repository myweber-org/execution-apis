
FileEncryption := Object clone do(
    encrypt := method(path, password,
        data := File with(path) openForReading contents
        salt := Random bytes(16)
        key := self deriveKey(password, salt, 32)
        iv := Random bytes(16)
        
        encrypted := self aes256CbcEncrypt(data, key, iv)
        header := salt .. iv
        File with(path .. ".enc") openForUpdating write(header .. encrypted) close
        "Encrypted file saved as #{path}.enc" interpolate
    )
    
    decrypt := method(path, password,
        data := File with(path) openForReading contents
        salt := data slice(0, 16)
        iv := data slice(16, 32)
        encrypted := data slice(32)
        
        key := self deriveKey(password, salt, 32)
        decrypted := self aes256CbcDecrypt(encrypted, key, iv)
        outputPath := path exSlice(0, -4)
        File with(outputPath) openForUpdating write(decrypted) close
        "Decrypted file saved as #{outputPath}" interpolate
    )
    
    deriveKey := method(password, salt, keyLength,
        iterations := 100000
        hash := MD5 clone
        block := salt .. password
        for(i, 0, iterations - 1,
            block = hash reset appendSeq(block) sum slice(0, 16)
        )
        block slice(0, keyLength)
    )
    
    aes256CbcEncrypt := method(data, key, iv,
        padded := self pkcs7Pad(data, 16)
        blocks := padded asBytes slice(0) groupedAt(16)
        encrypted := List clone
        previous := iv
        blocks foreach(block,
            xored := self xorBytes(block, previous)
            encrypted append(self aesEncryptBlock(xored, key))
            previous = encrypted last
        )
        encrypted join
    )
    
    aes256CbcDecrypt := method(data, key, iv,
        blocks := data asBytes slice(0) groupedAt(16)
        decrypted := List clone
        previous := iv
        blocks foreach(block,
            decryptedBlock := self aesDecryptBlock(block, key)
            plain := self xorBytes(decryptedBlock, previous)
            decrypted append(plain)
            previous = block
        )
        self pkcs7Unpad(decrypted join)
    )
    
    aesEncryptBlock := method(block, key,
        state := block clone
        roundKeys := self keyExpansion(key)
        self addRoundKey(state, roundKeys slice(0, 16))
        
        for(round, 1, 9,
            self subBytes(state)
            self shiftRows(state)
            self mixColumns(state)
            self addRoundKey(state, roundKeys slice(round*16, 16))
        )
        
        self subBytes(state)
        self shiftRows(state)
        self addRoundKey(state, roundKeys slice(160, 16))
        state
    )
    
    pkcs7Pad := method(data, blockSize,
        padding := blockSize - (data size % blockSize)
        data .. (padding asCharacter repeated(padding))
    )
    
    pkcs7Unpad := method(data,
        padding := data at(-1)
        data exSlice(0, -padding)
    )
    
    xorBytes := method(a, b,
        result := List clone
        a foreach(i, v, result append(v ^ b at(i)))
        result
    )
)

if(isLaunchScript,
    if(System args size == 4,
        action := System args at(1)
        file := System args at(2)
        password := System args at(3)
        
        if(action == "encrypt",
            FileEncryption encrypt(file, password) println
        ,
            if(action == "decrypt",
                FileEncryption decrypt(file, password) println
            ,
                "Usage: io file_encryption.io [encrypt|decrypt] <file> <password>" println
            )
        )
    ,
        "Usage: io file_encryption.io [encrypt|decrypt] <file> <password>" println
    )
)