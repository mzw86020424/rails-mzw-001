require "test_helper"

class Api::V1::TweetTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_tweet_tags_create_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_tweet_tags_destroy_url
    assert_response :success
  end
end
