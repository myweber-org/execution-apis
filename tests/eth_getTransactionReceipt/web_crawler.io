
URL := "https://example.com"
title := URL fetch asXML root at("head") at("title") asString
title println