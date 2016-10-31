class Parsers::HeaderParser
  def element_tags
    %w(h1 h2 h3)
  end

  def build_tag(nokogiri_element)
    Tag.new(name: nokogiri_element.name, content: nokogiri_element.children.to_s)
  end
end
