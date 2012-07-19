require 'spec_helper'

describe CelebritiesController do
  render_views

  describe "GET index" do
    before(:each) do
      @celeb1 = FactoryGirl.create(:celebrity)
      @celeb2 = FactoryGirl.create(:celebrity)
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have a list of all the celebrities" do
      get :index
      Celebrity.all.each do |celeb|
        response.should have_selector("li", content: celeb.screen_name)
      end
    end
  end
end
