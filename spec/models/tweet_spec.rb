require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '#create' do
    let(:user) { User.create(
      name: Faker::Name.first_name,
      email: Faker::Internet.email,
      password: "password",
      token: "token",
      ) } 
    context "without nothing" do
      it "true" do
        t = Tweet.new(text: "hoge", user_id: user.id)
        expect(t.save!).to eq true
      end
    end
  end
end
