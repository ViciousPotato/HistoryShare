# 100M
db = openDatabase('history', '1.0', 'Main database', 100 * 1024 * 1024)
db.transaction (tx) ->
	tx.executeSql('CREATE TABLE IF NOT EXISTS history (id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, timestamp TIMESTAMP)')

chrome.webNavigation.onCommitted.addListener (details) ->
	###
	Filter out urls below:
	1. qualifier = auto_frame
	2. url = "about.blank"

	Check more detailed doc at:
	http://developer.chrome.com/extensions/webNavigation.html
	###

	if details.url == "about:blank" then return

	if details.transitionType in ["auto_subframe"] then return

	console.log details.timeStamp
	console.log details
	
	# Save to db
	db.transaction (tx) ->
		tx.executeSql(
			'INSERT INTO history (url, timestamp) VALUES (?, ?)', 
			[details.url, details.timeStamp])



