# Description:
#   A way to interact with arXiv API.
#
# Commands:
#   hubot arxiv me <word> - The Original. Queries arXiv http://arxiv.org for <query> and returns a 10 latest items.


request = require('request')
parser = require('feedparser')

module.exports = (robot) ->
  robot.respond /(arxiv)( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[3], (url) ->
      msg.send url

imageMe = (msg, query, url) ->
  query_url = 'http://export.arxiv.org/api/query?search_query=all:' + query.replace(/\s+/, "+")
  result  = []
  index = 0
  rs = request(query_url)
  fp = rs.pipe(new parser())
    .on('readable', () ->
       stream = fp
       index = index + 1
       while item = stream.read()
         msg.send "#{item.title}\n#{item.link.replace("/abs/", "/pdf/")}"
    )





