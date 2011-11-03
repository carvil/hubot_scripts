module.exports = (robot) ->
  robot.respond /what's the status of the (.*) line$/i, (msg) ->
    line = msg.match[1]
    url = "http://api.tubeupdates.com/?method=get.status&lines=#{line}"
    msg.http(url)
      .get() (err, res, body) ->
        result = JSON.parse(body)
        if result.response.lines
          line = result.response.lines[0]
          msg.send "#{line.status} on the #{line.id} line"
        else
          msg.send "couldn't get the status of the '#{line}' line..."
