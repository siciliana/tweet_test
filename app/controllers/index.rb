get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  if @user.tweets.empty? || @user.tweets_stale?
    @user.fetch_tweets!
  end
  @tweets_all_info = @user.cached_tweets
  erb :index
end