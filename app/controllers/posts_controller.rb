class PostsController < ApplicationController
  POSTS_PER_PAGE = 2
  def index
    @page = params.fetch(:page, 0).to_i
    @page = 0 if @page.negative? || @page > (Post.count / POSTS_PER_PAGE)
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(comments: [:author]).offset(@page * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:author)
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      puts @post
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
