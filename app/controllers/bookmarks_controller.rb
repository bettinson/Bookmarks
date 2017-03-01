class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def new
  end

  def create
    url = params[:url]
    description = params[:description]
    # Temporary work around as bookmarks belong to a user
    @user = User.new(name: "Matt Bettinson", email: "mattbettinson@me.com", password: "password", password_confirmation: "password")
    bookmark = Bookmark.new(url: url, description: description)
    bookmark.user = @user
    unless bookmark.valid?
      redirect_to bookmarks_new_path, notice: "Invalid bookmark."
    end
    bookmark.save
    redirect_to root_url, notice: "Bookmark saved."
    # valid_bookmark?
  end

  def destroy
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update(url: params[:url], description: params[:description])
      redirect_to root_url
    else
      redirect_to :controller => "bookmarks", :action => "edit", :id => @bookmark.id, :notice => "message fine" 
    end
  end

  private 
  def valid_bookmark?
    if @url.empty? || @description.empty?
    end
  end
end
