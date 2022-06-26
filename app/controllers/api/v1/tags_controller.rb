class Api::V1::TagsController < ApplicationController
    def create
        tag = Tag.new(name: params[:name])
        if tag.save
            render json: {
                status: 'SUCCESS',
                data: tag
            }
        else
            render json: {
                status: 'ERROR',
                data: tag.error
            }
        end
    end

    def tagged_tweets
        tag = Tag.find(params[:tag_id])
        render json: {
            status: 'SUCCESS',
            data: tag.tweets
        }
    end
    
end
