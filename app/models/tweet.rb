class Tweet < ApplicationRecord
  include Visible

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :tweet_tags, dependent: :destroy
  has_many :tags, through: :tweet_tags, source: :tag

  with_options presence: true do
    validates :text
    validates :user_id
  end

  class << self

    def tweet_with_my_like(my_id)
      TweetResource.setMyId(my_id)
      tweet = self.eager_load(:likes).find(my_id)
      TweetResource.new(tweet)
    end

    def tweets_with_my_like(my_id)
      TweetResource.setMyId(my_id)
      tweets = self.eager_load(:likes).order(id: :desc).limit(50) # ここではまだSQL発行されていない
      TweetResource.setAllTweets(tweets)
      
      data = []
      for tweet in tweets do
        data.push(TweetResource.new(tweet))
      end

      data
    end

  end

end
