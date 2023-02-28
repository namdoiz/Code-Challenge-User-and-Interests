require "tilt/erubis"		
require "sinatra"
require "sinatra/reloader"
require 'yaml'


before do
  @contents = Psych.load_file("data/users.yaml")
end

helpers do
  def just_names(hash)
    hash.keys.map(&:capitalize)
  end

  def count_interests(hash)
    @number_of_interests = 0
    hash.values.each do |hash|
      @number_of_interests += hash[:interests].size
    end
    @number_of_interests
  end
end

get "/" do
  erb :home
end

get "/users/:name" do
  @name = params[:name]
  @email_and_interests = @contents.fetch_values(@name.downcase.to_sym)[0]
  @number_of_users = @contents.keys.size
  erb :user
end