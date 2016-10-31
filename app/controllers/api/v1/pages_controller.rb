class Api::V1::PagesController < ApplicationController
  def index
    render json: Page.includes(:tags).all
  end

  def create
    parsing_result = PageParser.new.parse(params[:url], pipeline: parser_pipeline)
    if parsing_result.success?
      render json: parsing_result.page, status: :ok
    else
      render json: { errors: parsing_result.errors }, status: :bad_request
    end
  end

private

  def parser_pipeline
    ParserPipeline.new(Parsers::HeaderParser.new, Parsers::LinkParser.new)
  end
end
