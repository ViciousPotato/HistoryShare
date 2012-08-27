$(document).ready ->
	db = openDatabase('history', '1.0', 'Main database', 100 * 1024 * 1024)
	db.transaction (tx) ->
		tx.executeSql 'SELECT * FROM history', [], (tx, results) ->
			$("#result").append "<li>#{results.rows.item(i).log}</li>" for i in [0..results.rows.length-1]