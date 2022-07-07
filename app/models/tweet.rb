class Tweet < ApplicationRecord
  include Visible

  attribute :liked_by_me, :boolean
  attribute :like_count, :integer

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :tweet_tags, dependent: :destroy
  has_many :tags, through: :tweet_tags, source: :tag

  with_options presence: true do
    validates :text
    validates :user_id
  end
end
