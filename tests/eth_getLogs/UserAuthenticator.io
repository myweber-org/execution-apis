
UserAuthenticator := Object clone do(
    users := Map clone

    init := method(
        self users atPut("admin", "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8") // password: password
    )

    hashPassword := method(password,
        password asSHA256
    )

    register := method(username, password,
        if(users hasKey(username),
            return "Username already exists"
        )
        hashedPassword := hashPassword(password)
        users atPut(username, hashedPassword)
        "Registration successful"
    )

    login := method(username, password,
        storedHash := users at(username)
        if(storedHash isNil, return "User not found")
        if(hashPassword(password) == storedHash,
            "Login successful",
            "Invalid password"
        )
    )

    changePassword := method(username, oldPassword, newPassword,
        if(login(username, oldPassword) beginsWith("Login"),
            users atPut(username, hashPassword(newPassword))
            "Password changed successfully",
            "Cannot change password: authentication failed"
        )
    )

    listUsers := method(
        users keys
    )
)

// Example usage
auth := UserAuthenticator clone
auth register("alice", "secret123")
writeln(auth login("alice", "secret123"))
writeln(auth login("admin", "password"))
writeln(auth listUsers)