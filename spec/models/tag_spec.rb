describe Tag do
  context 'validations' do
    it { is_expected.to validate_presence_of(:page) }
    it { is_expected.to validate_presence_of(:name) }
  end
end
