$(document).ready ->
  chrome.history.search
    text: ''
    maxResults: 10000
  , (results) ->
    stats = 
      _.chain(results)
       .countBy((result) -> URI(result.url).domain())
       .map((val, k) -> { domain: k, hits: val })
       .sortBy((o) -> o.hits)
       .each((o) -> $('body').append "#{o.domain}: #{o.hits}<br>")
      
