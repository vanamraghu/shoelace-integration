class PostsController < ApplicationController


  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    if user_signed_in?
      @post = Post.new
    else
      redirect_to new_sessions_path, alert: "Please log in for creating the post!!!"
    end

  end

  # GET /posts/1/edit
  def edit
    if user_signed_in?
      @post = Post.find(params[:id])
      unless @post.id == current_user.id
        redirect_to posts_url, alert: "You are not authorized to edit this post!" unless @post.user == current_user
      end
    else
      redirect_to new_sessions_path, alert: "Please log in for editing the posts!!!"
    end

  end

  # POST /posts or /posts.json
  def create
    @posts = Post.new(post_params)
    @posts.user = current_user
    if @posts.save
      flash[:notice] = "Post created successfully"
      redirect_to posts_path
    else
      flash.now[:alert] = "Please provide title & description for creating posts"
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = "Updated post successfully"
    redirect_to post_url @post
  end
  

  private


    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description)
    end
end
