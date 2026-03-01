
FileProcessor := Object clone do(
    filePath ::= nil

    withPath := method(path,
        self clone setFilePath(path)
    )

    exists := method(
        File with(self filePath) exists
    )

    size := method(
        if(self exists, File with(self filePath) size, 0)
    )

    lineCount := method(
        count := 0
        if(self exists,
            File with(self filePath) openForReading foreachLine(
                count = count + 1
            )
        )
        count
    )

    extension := method(
        if(self exists,
            path := self filePath
            dotIndex := path findSeq(".")
            if(dotIndex, path slice(dotIndex + 1), "")
        )
    )
)