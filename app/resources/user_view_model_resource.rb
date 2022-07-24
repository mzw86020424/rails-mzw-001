class UserViewModelResource
    include Alba::Resource
    one :user, resource: UserResource
    attributes :follows_me, :followed_by_me, :follower_count, :followee_count, :tweet_count
end