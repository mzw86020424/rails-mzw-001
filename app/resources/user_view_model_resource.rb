class UserViewModelResource
    include Alba::Resource
    one :user, resource: UserResource
    attributes :follows_me, :followed_by_me
end