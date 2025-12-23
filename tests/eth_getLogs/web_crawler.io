
URL := "https://www.example.com"
title := URL fetch asXML root at("head") at("title") text
("Page title: " .. title) println