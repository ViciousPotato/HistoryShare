var db;

db = openDatabase('history', '1.0', 'Main database', 100 * 1024 * 1024);

db.transaction(function(tx) {
  return tx.executeSql('CREATE TABLE IF NOT EXISTS history (id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, timestamp TIMESTAMP)');
});

chrome.webNavigation.onCommitted.addListener(function(details) {
  /*
  	Filter out urls below:
  	1. qualifier = auto_frame
  	2. url = "about.blank"
  
  	Check more detailed doc at:
  	http://developer.chrome.com/extensions/webNavigation.html
  */

  var _ref;
  if (details.url === "about:blank") {
    return;
  }
  if ((_ref = details.transitionType) === "auto_subframe") {
    return;
  }
  console.log(details.timeStamp);
  console.log(details);
  return db.transaction(function(tx) {
    return tx.executeSql('INSERT INTO history (url, timestamp) VALUES (?, ?)', [details.url, details.timeStamp]);
  });
});
