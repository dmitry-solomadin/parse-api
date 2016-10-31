class Parsers::LinkParser
  def element_tags
    %w(a)
  end

  def build_tag(nokogiri_element)
    Tag.new(name: nokogiri_element.name, content: nokogiri_element.attribute('href'))
  end
end
