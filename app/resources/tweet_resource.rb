class TweetResource
    include Alba::Resource
    attributes :id, :text, :user_id
end