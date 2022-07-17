class TweetViewModel
    attr_accessor :tweet, :liked_by_me, :like_count
    def initialize(tweet, liked_by_me, like_count)
        @tweet = tweet
        @liked_by_me = liked_by_me
        @like_count = like_count
    end
end