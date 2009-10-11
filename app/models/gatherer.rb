require 'net/http'
require 'uri'

class Gatherer
  def self.retrieve_mtg_id(name)
    urlString = "http://gatherer.wizards.com/Pages/Card/Details.aspx?name=#{name}"
    url = URI.parse(urlString)
    result = Net::HTTP.start(url.host, url.port) { |http|
      http.get("#{url.path}?#{url.query}")
    }
    body = result.body
    body.scan(/multiverseid=(\d+)/).flatten.first
  end

  def self.parse(body)
    results = {}
    results[:mtg_id] = body.scan(/multiverseid=(\d+)/).flatten.first
    results[:type] = body.scan(/multiverseid=(\d+)/).flatten.first
    results[:mtg_id] = body.scan(/multiverseid=(\d+)/).flatten.first
  end
end
