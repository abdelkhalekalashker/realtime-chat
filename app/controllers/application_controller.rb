class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_query
    def set_query
        @query = Message.ransack(params[:q])
    end
end
