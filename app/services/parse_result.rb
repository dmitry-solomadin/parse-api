class ParseResult
  attr_reader :page, :errors

  def self.success(page)
    new(page: page)
  end

  def self.failure(errors)
    new(errors: errors)
  end

  def success?
    @is_success
  end

  private

  def initialize(errors: {}, page: nil)
    @is_success = page.present?
    @errors = errors
    @page = page
  end
end
