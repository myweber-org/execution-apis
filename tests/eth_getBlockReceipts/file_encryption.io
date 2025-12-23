
Cipher := Object clone do(
    encrypt := method(data, key,
        iv := Random bytes(16)
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setKey(key)
        cipher setIV(iv)
        cipher setPadding(true)
        encrypted := cipher encrypt(data)
        result := iv asBase64 .. ":" .. encrypted asBase64
        result
    )

    decrypt := method(encryptedData, key,
        parts := encryptedData split(":")
        if(parts size != 2, return nil)
        iv := parts at(0) fromBase64
        data := parts at(1) fromBase64
        cipher := OpenSSL Cipher with("aes-256-cbc")
        cipher setKey(key)
        cipher setIV(iv)
        cipher setPadding(true)
        decrypted := cipher decrypt(data)
        decrypted
    )
)

KeyGenerator := Object clone do(
    generateKey := method(
        Random bytes(32) asBase64
    )
)