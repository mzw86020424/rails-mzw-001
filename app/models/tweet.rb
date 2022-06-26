class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :like_users, through: :likes, source: :user
  has_many :tweet_tags
  has_many :tags, through: :tweet_tags, source: :tag
end
