class UserViewModel
    attr_accessor :user, :follows_me, :followed_by_me
    def initialize(user, follows_me, followed_by_me)
        @user = user
        @follows_me = follows_me
        @followed_by_me = followed_by_me
    end
end