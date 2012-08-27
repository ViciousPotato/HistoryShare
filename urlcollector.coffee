# 100M
db = openDatabase('history', '1.0', 'Main database', 100 * 1024 * 1024)
db.transaction (tx) ->
	tx.executeSql('CREATE TABLE history (id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT)')

chrome.webNavigation.onCommitted.addListener (details) ->
	console.log details
	###
	Filter out urls below:
	1. qualifier = auto_frame
	2. url = "about.blank"

	Check more detailed doc at:
	http://developer.chrome.com/extensions/webNavigation.html
	###

	if details.url == "about:blank" then return

	if details.transitionType in ["auto_subframe"] then return

	# Save to db
	db.transaction (tx) ->
		tx.executeSql('INSERT INTO history (url) VALUES (?)', [details.url])


