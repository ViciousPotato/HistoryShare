(function() {

  $(document).ready(function() {
    var db;
    db = openDatabase('history', '1.0', 'Main database', 100 * 1024 * 1024);
    return db.transaction(function(tx) {
      return tx.executeSql('SELECT * FROM history', [], function(tx, results) {
        var i, _i, _ref, _results;
        console.log(results);
        console.log('showhistory');
        _results = [];
        for (i = _i = 0, _ref = results.rows.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          _results.push($("#result").append("<li>" + (results.rows.item(i).url) + "</li>"));
        }
        return _results;
      }, function(tx, error) {
        return console.log(error);
      });
    });
  });

}).call(this);
