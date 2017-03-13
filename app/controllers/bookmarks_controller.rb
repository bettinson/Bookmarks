class BookmarksController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :destroy]

  def index
    @bookmarks = Bookmark.all
  end

  def new
  end

  def create
    url = params[:url]
    description = params[:description]
    tags = split_tags(params[:tags])
    bookmark = Bookmark.new(url: url, description: description)

    unless tags.nil? || tags.empty?
      tags.each do |t|
        bookmark.tags.append Tag.new(name: t)
      end
    end

    bookmark.user = current_user
    current_user.bookmarks << bookmark

    unless bookmark.valid?
      redirect_to bookmarks_new_path, notice: "Invalid bookmark."
      return
    end
    bookmark.save
    redirect_to root_url, notice: "Bookmark saved."
    # valid_bookmark?
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.user == current_user
      if @bookmark.destroy
        redirect_to bookmarks_index_url, notice: "Bookmark was deleted!"
      else
        redirect_to bookmarks_index_url, notice: "Bookmark was unable to be deleted."
      end
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    unless @bookmark.user == current_user
      redirect_to bookmarks_index_url, notice: "That isn't your bookmark."
    end
  end

  def show
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

  def split_tags(tags)
    tags.split(' ') unless tags.nil?
  end
end
