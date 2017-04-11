class BookmarksController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :destroy, :react]

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
        tag = Tag.where(name: t).first_or_initialize
        bookmark.tags.append tag
        tag.save
      end
    end

    bookmark.user = current_user
    current_user.bookmarks.append bookmark

    unless bookmark.valid?
      redirect_to bookmarks_new_path, notice: "Invalid bookmark."
      return
    end

    bookmark.save
    redirect_to root_url, notice: "Bookmark saved."
  end

  def react
    @bookmark = Bookmark.find(params[:id])
    @reaction = Reaction.where(bookmark_id: @bookmark.id, user_id: current_user.id).first_or_initialize

    vote = params[:liked].to_i
    @reaction.liked = 0

    # Should probably do this checking on the model
    unless vote > 1 || vote < -1
      can_vote = false

      unless @reaction.liked == vote
        can_vote = true
      end

      previous_reaction = @reaction.liked

      @reaction.liked = vote 
      if @bookmark.score.nil?
        @bookmark.score = @reaction.liked
      else
        @bookmark.score += @reaction.liked - previous_reaction if can_vote
      end
    end

    # Don't want to append the same one twice
    @bookmark.reactions.append @reaction unless @reaction.bookmark == @bookmark
    @bookmark.save
    @reaction.save
    redirect_to bookmarks_index_url
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.user = current_user
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
      false
    end
  end

  def split_tags(tags)
    tags.split(' ') unless tags.nil?
  end
end
