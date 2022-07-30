class TweetViewModel
    attr_accessor :tweet, :liked_by_me, :like_count, :followed_by_me
    def initialize(tweet, liked_by_me, like_count, followed_by_me)
        @tweet = tweet
        @liked_by_me = liked_by_me
        @like_count = like_count
        @followed_by_me = followed_by_me
    end
end