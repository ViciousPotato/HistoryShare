// Generated by CoffeeScript 1.3.3
var db;

db = openDatabase('history', '1.0', 'Main database', 100 * 1024 * 1024);

db.transaction(function(tx) {
  return tx.executeSql('CREATE TABLE history (id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT)');
});

chrome.webNavigation.onCommitted.addListener(function(details) {
  var _ref;
  console.log(details);
  /*
  	Filter out urls below:
  	1. qualifier = auto_frame
  	2. url = "about.blank"
  
  	Check more detailed doc at:
  	http://developer.chrome.com/extensions/webNavigation.html
  */

  if (details.url === "about:blank") {
    return;
  }
  if ((_ref = details.transitionType) === "auto_subframe") {
    return;
  }
  return db.transaction(function(tx) {
    return tx.executeSql('INSERT INTO history (url) VALUES (?)', [details.url]);
  });
});