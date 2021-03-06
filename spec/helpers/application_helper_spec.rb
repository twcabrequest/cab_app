# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ApplicationHelper do

  it 'should convert time to IST correctly.'do
    original_time = Time.now.utc
    expected_time = (original_time + 19800).strftime('%I:%M %p')
    converted_time = ist(original_time)
    converted_time.should == expected_time

  end

  context 'current user' do
    it 'should return the session user if the session has a user' do
      session[:okta_user] = "chuck_norris"
      CASClient::Frameworks::Rails::Filter.fake("chuck_norris")
      current_user.should == "chuck_norris"
    end

    it "should return nil if the session doesn't have a user" do
      current_user.should be_nil
    end
  end

  #context 'fetch previous request' do
  #  it 'should return list of request' do
  #    @req = build(:requester)
  #    request = create(:cab_request)
  #    req_list = fetch_prev_request
  #    req_list.should == [request]
  #  end
  #end

end
