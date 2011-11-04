# hubot what's on eat.st
# eat.st at King's Boulevard on 4th Nov 2011
# ->Hardcore Prawn
# ->Big Apple Hot Dogs
# ->The Ribman
# ->Jamon Jamon

jsdom = require "jsdom"

module.exports = (robot) ->
  robot.respond /what's on eat.st/i, (msg) ->
    url = "http://www.eat.st/kings-cross/"

    # Search the main page for links to events
    jsdom.env url, [ "http://code.jquery.com/jquery-1.5.min.js" ], (errors, window) ->
      days = window.$("div.heading-blue a")
      # For each link to a day
      days.each (i) ->
        day = @textContent + "\n"
        day_url = url + @_attributes._nodes.href._nodeValue
        jsdom.env day_url, [ "http://code.jquery.com/jquery-1.5.min.js" ], (sub_errors, sub_window) ->
          msg.send build_string(day, sub_window)

build_string = (day, window) ->
  result = day
  window.$("div.altText div h3 a").each (i) ->
    result += "->" + @textContent + "\n"
  result
