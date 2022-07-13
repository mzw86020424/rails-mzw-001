class TweetResource
    include Alba::Resource

    @@my_id = ""
    @@all_tweets = ""

    class << self
        def setMyId(my_id)
            @@my_id = my_id
        end

        def setAllTweets(all_tweets)
            @@all_tweets = all_tweets
        end
    end

    root_key :tweet

    attributes :id, :text, :user_id

    attribute :like_count do |tweet|
        @@all_tweets.find(tweet.id).likes.count
    end

    attribute :liked_by_me do |tweet|
        t = @@all_tweets.find(tweet.id).likes.select { |like| like.user_id == @@my_id}.length > 0
    end
end