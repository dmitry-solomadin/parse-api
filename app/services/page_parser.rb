require 'net/http'

class PageParser
  def parse(page_url, pipeline: ParserPipeline.new, url_parser: UrlParser.new)
    url = url_parser.parse(page_url)
    page = build_page(page_url, url, pipeline)

    page.save ? ParseResult.success(page) : ParseResult.failure(page.errors)

  rescue
    ParseResult.failure(url: ['is invalid'])
  end

private

  def build_page(page_url, response, pipeline)
    Page.new(url: page_url, tags: build_tags(Nokogiri::HTML(response), pipeline))
  end

  def build_tags(document, pipeline)
    document.css(pipeline.query).map do |element|
      pipeline.process_element(element)
    end
  end
end
