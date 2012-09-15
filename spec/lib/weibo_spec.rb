require 'spec_helper'

describe Weibo do

  before(:each) do
    # test user info
    # OverThePan
    @uid = 2658925734
    @screen_name = 'OverThePan'
  end

  it 'should show user by uid' do
    response = Weibo.user_show_by_uid(@uid)
    response['screen_name'].should eq(@screen_name)
  end

  it 'should show user by screen_name' do
    response = Weibo.user_show_by_screen_name(@screen_name)
    response['id'].should eq(@uid)
  end


end