require 'rails_helper'

RSpec.describe Tweet, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#create' do
    context 'without text' do
      it "false" do
        expect(Tweet.new(user_id: 1, status: "private").valid?).to eq false 
      end
    end
    context 'without user_id' do
      it "false" do
        expect(Tweet.new(text: "qqq", status: "private").valid?).to eq false 
      end
    end
    context 'without status' do
      it "false" do
        expect(Tweet.new(text: "qqq", user_id: 1).valid?).to eq false 
      end
    end
  end
end
