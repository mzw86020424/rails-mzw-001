class TweetResource
    include Alba::Resource
    attributes :id, :text, :user_id
end

class TweetViewModelResource
    include Alba::Resource
    one :tweet, resource: TweetResource
    attributes :liked_by_me, :like_count
end

class TweetViewModel
    attr_accessor :tweet, :liked_by_me, :like_count
    def initialize(tweet, liked_by_me, like_count)
        @tweet = tweet
        @liked_by_me = liked_by_me
        @like_count = like_count
    end
end