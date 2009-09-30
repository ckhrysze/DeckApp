require 'net/http'
require 'uri'

class Gatherer
  def self.find_m_id(name)
    urlString = "http://gatherer.wizards.com/Pages/Card/Details.aspx?name=#{name}"
    url = URI.parse(urlString)
    result = Net::HTTP.start(url.host, url.port) { |http|
      http.get("#{url.path}?#{url.query}")
    }
    body = result.body
    body.scan(/multiverseid=(\d+)/).first
  end
end
