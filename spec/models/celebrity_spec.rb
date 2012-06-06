# == Schema Information
#
# Table name: celebrities
#
#  id          :integer         not null, primary key
#  uid         :integer
#  screen_name :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Celebrity do

  before(:each) do
    @uid = 6
    @screen_name = "leozwa"
    @attr = { uid: 6, screen_name: "leozwa"}
  end

  it "should create a new instance of Celebrity" do
    Celebrity.create!(@attr)
  end

  it "should require a screen name" do
    no_name_celebrity = Celebrity.new(@attr.merge(screen_name: ""))
    no_name_celebrity.should_not be_valid
  end
end
