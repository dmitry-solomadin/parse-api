describe PageParser do
  describe '#parse' do
    specify 'it returns error in case of invalid url' do
      result = PageParser.new.parse('invalid://url')

      expect(result).to_not be_success
      expect(result.errors).to eq({ url: ['is invalid'] })
    end

    specify 'it parses document correctly' do
      pipeline = ParserPipeline.new(Parsers::HeaderParser.new, Parsers::LinkParser.new)
      url_parser = instance_double('UrlParser',
                                   parse: File.read(Rails.root.join('spec', 'fixtures', 'test.html')))

      result = PageParser.new.parse('http://example.com', pipeline: pipeline, url_parser: url_parser)

      expect(result).to be_success

      expect(result.page).to have_attributes(url: 'http://example.com')
      expect(result.page.tags.to_a).to match([
        have_attributes(name: 'h1', content: 'Example Domain 1 with <a href="http://example.com">test link</a>'),
        have_attributes(name: 'a', content: 'http://example.com'),
        have_attributes(name: 'h2', content: 'Example Domain 2'),
        have_attributes(name: 'h3', content: 'Example Domain 3'),
        have_attributes(name: 'a', content: 'http://example.com?link_without_content=true'),
        have_attributes(name: 'a', content: 'http://www.iana.org/domains/example'),
      ])
    end
  end
end
