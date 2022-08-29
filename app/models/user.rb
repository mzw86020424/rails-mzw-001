class User < ApplicationRecord
    has_secure_token
    # アソシエーション
    has_many :tweets, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :like_tweets, through: :likes, source: :tweet

    # follower = フォローしているやつ followee = フォローされているやつ
    # 自分がフォローしているユーザーとの「関係」を持つ
    has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id
    # 中間テーブルを通じて自分がフォローしている「ユーザー」を持つ
    has_many :followees, through: :active_relationships, source: :followee, dependent: :destroy
    # 自分をフォローしているユーザーとの「関係」を持つ
    has_many :passive_relationships, class_name: "Relationship", foreign_key: :followee_id
    # 中間テーブルを通じて自分をフォローしている「ユーザー」を持つ
    has_many :followers, through: :passive_relationships, source: :follower, dependent: :destroy

    # バリデーション
    with_options presence: true do
        validates :name
        validates :email
        validates :password
    end
    validates :email, uniqueness: true

    # コールバック
    before_save do
        self.name = self.name.capitalize # self->インスタンスを指している
    end

    before_validation :add_user_length, if: :short_name?

    def add_user_length
        self.name = self.name + "hogehoge"
    end

    def short_name?
        self.name.length < 4
    end

    # インスタンスメソッド
    def like_tweet_tags
        like_tweet_tags = []
        users = User.eager_load(tweets: :tags).where(tweets: {user_id: self.id})
        for user in users do
            tweets = user.tweets
            for tweet in tweets do
                tags = tweet.tags
                for tag in tags do
                    like_tweet_tags.push(tag)
                end
            end
        end
        like_tweet_tags
    end
    def status_tweets(status)
        Tweet.all.where(user_id: self.id, status: status)
    end

    # クラスメソッド
    class << self
        def test_1
            users = User.all
            for user in users do
                tweets = user.tweets
                for tweet in tweets do
                    tweet.text
                end
            end
        end
# SQL
# User Load (2.7ms)  SELECT `users`.* FROM `users`
# Tweet Load (3.1ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 1
# Tweet Load (1.3ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 2
# Tweet Load (1.4ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 3
# Tweet Load (1.1ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 4
# Tweet Load (1.1ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 5
# Tweet Load (1.0ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 6
# Tweet Load (1.0ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 7
# Tweet Load (0.9ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 8
# Tweet Load (0.9ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 9
# Tweet Load (1.6ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 10
# Tweet Load (1.8ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 11
# Tweet Load (1.2ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 12
# Tweet Load (1.0ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 13
# Tweet Load (1.0ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 14
# Tweet Load (1.0ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 15
# Tweet Load (1.5ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` = 18
        def test_2
            users = User.all.preload(:tweets)
            for user in users do
                tweets = user.tweets
                for tweet in tweets do
                    tweet.text
                end
            end
        end
# SQL
# User Load (3.5ms)  SELECT `users`.* FROM `users`
# Tweet Load (6.3ms)  SELECT `tweets`.* FROM `tweets` WHERE `tweets`.`user_id` IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
        def test_3
            users = User.all.eager_load(:tweets)
            for user in users do
                tweets = user.tweets
                for tweet in tweets do
                    tweet.text
                end
            end
        end
# SQL
# SQL (4.2ms)  SELECT `users`.`id` AS t0_r0, `users`.`name` AS t0_r1, `users`.`email` AS t0_r2, `users`.`created_at` AS t0_r3, `users`.`updated_at` AS t0_r4, `tweets`.`id` AS t1_r0, `tweets`.`text` AS t1_r1, `tweets`.`user_id` AS t1_r2, `tweets`.`created_at` AS t1_r3, `tweets`.`updated_at` AS t1_r4 FROM `users` LEFT OUTER JOIN `tweets` ON `tweets`.`user_id` = `users`.`id`
        def test_4
            users = User.all.includes(:tweets)
            for user in users do
                tweets = user.tweets
                for tweet in tweets do
                    tags = tweet.tags
                    for tag in tags do
                        p tag.name
                    end
                end
            end
        end

        def test_5
            users = User.all.includes(tweets: :tags)
            for user in users do
                tweets = user.tweets
                for tweet in tweets do
                    tags = tweet.tags
                    for tag in tags do
                        p tag.name
                    end
                end
            end
        end

        def test_6
            users = User.all.eager_load(tweets: :tags)
            for user in users do
                tweets = user.tweets
                for tweet in tweets do
                    tags = tweet.tags
                    for tag in tags do
                        p tag.name
                    end
                end
            end
        end
    end # ここまでクラスメソッド
end
