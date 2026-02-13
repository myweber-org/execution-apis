
URL := "https://www.example.com"
title := URL fetch asString betweenSeq("<title>", "</title>")
("Title: " .. title) println