class Api::V1::TagsController < ApplicationController
    def index
        render json: Tag.all
    end

    def create
        tag = Tag.new(name: params[:name])
        if tag.save
            render json: tag
        else
            render json: tag.errors
        end
    end

end
