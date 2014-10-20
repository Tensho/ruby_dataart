require_relative 'storage'
require 'sinatra'
require 'json'

s = Storage.new.load_from_file('words-in')

get '/add' do
  content_type :json
  s.add(params[:string]).to_h.to_json
end

get '/contains' do
  content_type :json
  { params[:string] => s.contains?(params[:string]) }.to_json
end

get '/find' do
  content_type :json
  s.find(params[:string]).to_json
end
