require_relative 'storage'
require 'sinatra'
require 'json'

s = Storage.new.load_from_file('words-in')

set :show_exceptions, false
set content_type: :json

get '/add' do
  s.add(params[:string]).to_h.to_json
end

get '/contains' do
  { params[:string] => s.contains?(params[:string]) }.to_json
end

get '/find' do
  s.find(params[:string]).to_json
end

error ArgumentError do
  { 'ArgumentError' => env['sinatra.error'].message }.to_json
end
