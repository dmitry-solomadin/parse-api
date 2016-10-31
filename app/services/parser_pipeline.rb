class ParserPipeline
  def initialize(*parsers)
    @parsers = parsers
  end

  def process_element(nokogiri_element)
    @parsers.find { |p| nokogiri_element.name.in?(p.element_tags)}.build_tag(nokogiri_element)
  end

  def query
    query = @parsers.map(&:element_tags).join(', ')
    query.present? ? query : '*'
  end
end
