$(document).ready ->
	chrome.tabs.create
		url: 'options.html'
	
	db = openDatabase('history', '1.0', 'Main database', 100 * 1024 * 1024)
	db.transaction (tx) -> 
		tx.executeSql(
			'SELECT * FROM history', 
			[], 
			(tx, results) -> 
				console.log(results)
				console.log('showhistory')
				$("#result").append "<li>#{results.rows.item(i).url}</li>" for i in [0 .. results.rows.length - 1]
			(tx, error) -> console.log(error)
		)
	# Add comment to test auto compile