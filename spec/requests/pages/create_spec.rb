describe 'Pages', type: :request do
  before { ActiveSupport::JSON::Encoding.time_precision = 0 }

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
              'id' => page.tags.first.id,
              'name' => 'h1',
              'content' => 'Example Domain',
              'created_at' => page.tags.first.created_at.iso8601
            },
            {
              'id' => page.tags.last.id,
              'name' => 'a',
              'content' => 'http://www.iana.org/domains/example',
              'created_at' => page.tags.last.created_at.iso8601
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
