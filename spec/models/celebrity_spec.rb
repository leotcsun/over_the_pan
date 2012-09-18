# == Schema Information
#
# Table name: celebrities
#
#  id          :integer         not null, primary key
#  uid         :integer
#  domain      :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  screen_name :string(255)
#

require 'spec_helper'

describe Celebrity do

  before(:each) do
    @attr = { uid: 1, domain: "shangarang" }
  end

  it "should create a new instance of Celebrity" do
    Celebrity.create!(@attr)
  end

  it "should require a uid" do
    no_name_celebrity = Celebrity.new(@attr.merge(uid: ""))
    no_name_celebrity.should_not be_valid
  end

  it "should have a unique uid" do
    Celebrity.create!(@attr)
    duplicate = Celebrity.new(@attr)
    duplicate.should_not be_valid
  end

  describe "synchornization" do

    before(:each) do
      @attr = { uid: 2658925734, screen_name: 'OverThePan'}
    end

    it "should has all the posts of a celebrity" do
      user_show = Weibo.user_show_by_uid(@attr[:uid])
      celebrity = Celebrity.create!(@attr)
      celebrity.synchornize_post
      celebrity.posts.count.should be >= user_show['statuses_count']
    end

    # posting status isnt allowed... it seems...
    # it "should has the newest post" do
    #   params = {}
    #   content = Time.now
    #   params[:status] = content
    #   Weibo.statuses_update(@attr[:uid], params)

    #   celebrity = Celebrity.create!(@attr)
    #   celebrity.synchornize_post
    #   celebrity.posts.last.content.should eq(content)
    # end
  end
end
