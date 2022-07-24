class UserViewModel
    attr_accessor :user, :follows_me, :followed_by_me, :follower_count, :followee_count, :tweet_count
    def initialize(user, follows_me, followed_by_me, follower_count, followee_count, tweet_count)
        @user = user
        @follows_me = follows_me
        @followed_by_me = followed_by_me
        @follower_count = follower_count
        @followee_count = followee_count
        @tweet_count = tweet_count
    end
end