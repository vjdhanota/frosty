require 'omniauth'

class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more
    hash = spotify_user.to_hash
    redirect_to :controller => "home", :action => "index", :hash => hash, :method => :post
  end
end