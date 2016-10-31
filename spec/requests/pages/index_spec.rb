describe 'Pages', type: :request do
  before { ActiveSupport::JSON::Encoding.time_precision = 0 }

  describe 'GET /api/v1/pages' do
    it 'returns Pages' do
      page = Page.create!(url: 'http://example.com', tags: [
        Tag.new(name: 'a', content: 'link'),
        Tag.new(name: 'p', content: 'paragraph')
      ])

      get '/api/v1/pages'

      expect(response.status).to eq 200

      expect(json).to eq([{
                           'id' => page.id,
                           'url' => 'http://example.com',
                           'created_at' => page.created_at.iso8601,
                           'tags' =>
                             [
                               {
                                 'id' => page.tags.first.id,
                                 'name' => 'a',
                                 'content' => 'link',
                                 'created_at' => page.tags.first.created_at.iso8601
                               },
                               {
                                 'id' => page.tags.last.id,
                                 'name' => 'p',
                                 'content' => 'paragraph',
                                 'created_at' => page.tags.last.created_at.iso8601
                               }
                             ]
                         }])
    end
  end
end
