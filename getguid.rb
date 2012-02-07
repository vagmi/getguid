require 'rubygems'
require 'bundler'
Bundler.require

get '/guids.json' do
  count = params[:count]
  count ||= 100
  count = count.to_i if (count.is_a? String) 
  count = 100 if count < 1
  count=300 if count > 300
  guids=1.upto(count).map { Guid.new.to_s.gsub("-","") }
  guids.to_json
end
