get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  p user = Twitter.user(params[:username])
  if user.tweets_stale?
    user.fetch_tweets!
  end
  
  tweets = @user.tweets.limit(10)
  
  if request.xhr?
    erb :tweets, layout: false
  else
    "error"
  end
end