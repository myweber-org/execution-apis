
MessageLog := Object clone do(
    messages := List clone

    log := method(sender, content,
        timestamp := Date now asString("%Y-%m-%d %H:%M:%S")
        message := Map clone atPut("sender", sender) atPut("content", content) atPut("timestamp", timestamp)
        messages append(message)
        self
    )

    recentMessages := method(count,
        messages slice(messages size - count max(0))
    )

    findBySender := method(senderName,
        messages select(m, m at("sender") == senderName)
    )

    clear := method(
        messages removeAll
        self
    )
)

processor := MessageLog clone

processor log("Alice", "Meeting scheduled for 3 PM")
processor log("Bob", "Project update: Phase 1 completed")
processor log("Alice", "Please review the latest design mockups")
processor log("Charlie", "Server maintenance scheduled tonight")

"Recent 2 messages:" println
processor recentMessages(2) foreach(msg,
    "[#{msg at(\"timestamp\")}] #{msg at(\"sender\")}: #{msg at(\"content\")}" interpolate println
)

"\nMessages from Alice:" println
processor findBySender("Alice") foreach(msg,
    "[#{msg at(\"timestamp\")}] #{msg at(\"content\")}" interpolate println
)