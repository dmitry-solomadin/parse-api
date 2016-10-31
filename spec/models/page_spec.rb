describe Page do
  before { Page.create!(url: 'test') }

  context 'validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }
  end
end
