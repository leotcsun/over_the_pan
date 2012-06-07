# == Schema Information
#
# Table name: celebrities
#
#  id         :integer         not null, primary key
#  uid        :integer
#  domain     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Celebrity do

  before(:each) do
    @attr = { uid: 1, domain: "shangarang" }
  end

  it "should create a new instance of Celebrity" do
    Celebrity.create!(@attr)
  end

  it "should require a domain" do
    no_name_celebrity = Celebrity.new(@attr.merge(domain: ""))
    no_name_celebrity.should_not be_valid
  end

  it "should have a unique domain" do
    Celebrity.create!(@attr)
    duplicate = Celebrity.new(@attr)
    duplicate.should_not be_valid
  end
end
