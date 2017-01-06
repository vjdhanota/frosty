
class HomeController < ApplicationController
  require 'forecast_io'
  require 'omniauth'
  before_action :set_playlist, only: [:index]

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
  	@user = RSpotify::User.new(params[:hash])
  	@playlist = @user.create_playlist!('Frosty Playlist')
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
 
  	@playlists_set = RSpotify::Playlist.search(@theQuery, limit: 30) #query should be adjusted to current weather
  	ps_len = @playlists_set.count - 1
 	@selected_list = @playlists_set[rand(0..ps_len)]


  	#CREATE LIST OF PLAYLISTS FOR EACH WEATHER CONDITION?
  	#SPOTIFY API NOT LETTING YOU SEARCH FOR PLAYLISTS
  end

end
