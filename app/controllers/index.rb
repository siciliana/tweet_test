get '/' do
  erb :index
end

get '/tweet' do
  erb :tweets
end

# ==========new way ======================================

post '/add_new_tweets' do
  @user = TwitterUser.find_by_screen_name(params[:username])
  if @user.tweets_stale? 
    @tweets = @user.get_new_tweets! 
    erb :_moretweets, layout: false
  end
end

post '/use_ajax' do
  p @user = TwitterUser.find_or_create_by_username(params[:username])
  # if @user == nil
  #   @user = TwitterUser.create(screen_name: params[:username])
  # end
  redirect to "/#{@user.username}"
end

# ================old way==========
get '/:screen_name' do
  @user = Twitter.user(params[:screen_name])
  @tweets = Twitter.user_timeline(params[:screen_name])
  erb :tweets
end

# post '/get_tweets' do
#   @user = TwitterUser.find_by_screen_name(params[:username])
#   if @user 
#     @user.update_tweets! if @user.tweets_stale?

#   else
#     @user = TwitterUser.create(screen_name: params[:username])
#     @user.update_tweets!(true)
#   end

#   redirect to "/#{@user.screen_name}"
# end

post '/submit_tweet' do
  Twitter.update(params[:submitted_tweet])

  redirect to '/siciliana'
end