class TweetViewModelResource
    include Alba::Resource
    one :tweet, resource: TweetResource
    attributes :liked_by_me, :like_count
end
