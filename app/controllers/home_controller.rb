
class HomeController < ApplicationController
  require 'forecast_io'
  require 'omniauth'
  before_action :set_playlist, only: [:index, :save]

  def index
  	@summary = set_weather.currently.icon
  end

  private
  ForecastIO.configure do |configuration|
    configuration.api_key = ENV['FORECAST_CLIENT_ID']
  end

  def set_weather
	ForecastIO.forecast(37.3382, -121.8863)
  end

  def set_playlist
  	#Verify that we have current_user 
  	if params.has_key?(:save)

  	end
  	if params.has_key?("RSpotify::User")

	  	hash = params["RSpotify::User"][:hash]
	  	@user = RSpotify::User.new(hash)
	  	@current_weather = set_weather.currently.icon
	  	@theQuery = 'everyday music'

	  	case @current_weather
		  	when "clear-day"
		  		@theQuery = 'summer music'
		  	when "clear-night"
		  		@theQuery = 'night'
		  	when "rain"
		  		@theQuery = 'rainy weather'
		  	when "wind"
		  		@theQuery = 'cold weather'
		  	when "fog"
		  		@theQuery = 'foggy'
		  	when "cloudy"
		  		@theQuery = 'cloudy'
	  	end
	 
	  	@playlists_set = RSpotify::Playlist.search(@theQuery, limit: 50) #query should be adjusted to current weather
	  	ps_len = @playlists_set.count - 1
	 	@selected_list = @playlists_set[rand(0..ps_len)] #SELECT A RANDOM PLAYLIST

	 	@playlist_id = @selected_list.id
	 	@owner_id = @selected_list.owner.id

	 	@embed_link = "https://embed.spotify.com/?uri=spotify:user:" + @owner_id + ":playlist:" + @playlist_id
	
	#Otherwise, we must authorize the user again and generate a new playlist
 	else 
 	render "users/spotify"
 	end	
  		
  end

end
