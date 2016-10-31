class UrlParser
  def parse(url)
    Net::HTTP.get_response(URI.parse(url)).body
  end
end
