class Api::V1::TweetTagsController < ApplicationController
  def create
    tag = Tag.find(params[:tag_id])
    tweet = Tweet.find(params[:tweet_id])
    tweet_tag = TweetTag.new(tweet_id: tweet.id, tag_id: tag.id)
    if tweet_tag.save
        render json: {
            status: "SUCCESS",
            data: tweet_tag
        }
    else
        render json: {
            status: "ERROR",
            data: tweet_tag.error
        }
    end
  end

  def destroy
  end
end
