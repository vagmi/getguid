require './getguid'
require 'rspec'
require 'rack/test'

describe 'GetGuid App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'I should get 100 guids' do
    get '/guids.json'
    last_response.should be_ok
    guids=JSON.parse(last_response.body)
    guids.count.should == 100
  end

  it 'I should get 200 guids' do
    get '/guids.json?count=200'
    last_response.should be_ok
    guids=JSON.parse(last_response.body)
    guids.count.should==200
  end

  it 'I should get 300 guids if count is greater than 300' do
    get '/guids.json?count=700'
    last_response.should be_ok
    guids=JSON.parse(last_response.body)
    guids.count.should==300
  end

  it 'I should get 100 guids if count is not a number' do
    get '/guids.json?count=asdf'
    last_response.should be_ok
    guids=JSON.parse(last_response.body)
    guids.count.should==100
  end

  it 'All the guids I get should all be unique' do
    get '/guids.json?count=asdf'
    last_response.should be_ok
    guids=JSON.parse(last_response.body)
    checked_guids = []
    guids.each do |g|
      checked_guids.index(g).should be_nil
      checked_guids << g
    end
  end
end
