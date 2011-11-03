module.exports = (robot) ->
  robot.respond /what's the status of the (.*) line$/i, (msg) ->
    url = "http://api.tubeupdates.com/?method=get.status&lines=#{msg.match[1]}"
    msg.http(url)
      .get() (err, res, body) ->
        result = JSON.parse(body)
        line = result.response.lines[0]
        msg.send "#{line.status} on the #{line.name} line"
