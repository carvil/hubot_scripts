module.exports = (robot) ->
  robot.respond /(.*) stands for/i, (msg) ->
    url = "http://www.urbandictionary.com/iphone/search/define?term=#{msg.match[1]}"
    max_thumbs_up = 0
    response = "no idea"
    msg.http(url).get() (err, res, body) ->
      result = JSON.parse(body)
      for def in result.list
        if def.thumbs_up > max_thumbs_up
          max_thumbs_up = def.thumbs_up
          response = def.definition
      msg.send response
