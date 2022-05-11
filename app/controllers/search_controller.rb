class SearchController < ApplicationController
  def index
    @query = Message.ransack(params[:q])
    @messages = @query.result.includes(:room)
  end
end
