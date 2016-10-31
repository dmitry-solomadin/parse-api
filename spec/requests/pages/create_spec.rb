describe 'Pages', type: :request do
  before do
    ActiveSupport::JSON::Encoding.time_precision = 0
    stub_request(:get, 'http://example.com').
      to_return(body: File.read(Rails.root.join('spec', 'fixtures', 'test.html'),
                status: 200,
                headers: { 'Content-Length' => 3 }))
  end

  describe 'POST /api/v1/pages' do
    it 'parses the page without errors' do
      post '/api/v1/pages', url: 'http://example.com'

      expect(response.status).to eq 200

      page = Page.last

      expect(json).to eq({
        'id' => page.id,
        'url' => 'http://example.com',
        'created_at' => page.created_at.iso8601,
        'tags' =>
          [
            {
              'id' => page.tags[0].id,
              'name' => 'h1',
              'content' => "Example Domain 1 with <a href=\"http://example.com\">test link</a>",
              'created_at' => page.tags[0].created_at.iso8601
            },
            {
              'id' => page.tags[1].id,
              'name' => 'a',
              'content' => 'http://example.com',
              'created_at' => page.tags[1].created_at.iso8601
            },
            {
              'id' => page.tags[2].id,
              'name' => 'h2',
              'content' => 'Example Domain 2',
              'created_at' => page.tags[2].created_at.iso8601
            },
            {
              'id' => page.tags[3].id,
              'name' => 'h3',
              'content' => 'Example Domain 3',
              'created_at' => page.tags[3].created_at.iso8601
            },
            {
              'id' => page.tags[4].id,
              'name' => 'a',
              'content' => 'http://example.com?link_without_content=true',
              'created_at' => page.tags[4].created_at.iso8601
            },
            {
              'id' => page.tags[5].id,
              'name' => 'a',
              'content' => 'http://www.iana.org/domains/example',
              'created_at' => page.tags[5].created_at.iso8601
            }
          ]
        })
    end

    it 'it returns errors for page with invalid URL' do
      post '/api/v1/pages', url: 'invalid://url'

      expect(response.status).to eq 400
      expect(json).to eq({ 'errors' => { 'url' => ['is invalid'] } })
    end

    it 'it returns errors for page that already exists' do
      Page.create!(url: 'http://example.com')

      post '/api/v1/pages', url: 'http://example.com'

      expect(response.status).to eq 400
      expect(json).to eq({ 'errors' => { 'url' => ['has already been taken'] } })
    end
  end
end
