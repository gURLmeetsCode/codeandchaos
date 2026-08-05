class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[ show edit update destroy publish ]

  # GET /posts or /posts.json
  def index
    @posts = Post.newest_first
  end

  # GET /posts/1 or /posts/1.json - not needed here for now
  def show;end


  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit - not needed here for now
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_posts_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_posts_path, notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def publish
    @post.publish!

    redirect_back fallback_location: admin_dashboard_path,
                  notice: "\"#{@post.title}\" is now published."
  end

  private
    def set_post
      @post = Post.find(params.expect(:id))
    end

    def post_params
      params.expect(post: [ :title, :body, :topic, :published_at ])
    end
end
