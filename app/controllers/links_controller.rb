class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:visit]

  # GET /links or /links.json
 def index
  session[:shown_link_ids] ||= []

  # Get all IDs not shown yet
  unseen_ids = Link.where.not(id: session[:shown_link_ids]).pluck(:id)

  # Shuffle unseen and pick up to 1000
  random_ids = unseen_ids.sample(1000)

  # Load those links
  @links = Link.where(id: random_ids)

  # Track which ones were shown
  session[:shown_link_ids] += random_ids

  # Optional: Clear session if all links are shown
  if unseen_ids.size <= 1000
    session[:shown_link_ids] = []
  end
end


  # GET /links/1 or /links/1.json
  def show_random
  session[:shown_link_ids] ||= []

  # Find an unseen random link
  unseen_ids = Link.where.not(id: session[:shown_link_ids]).pluck(:id)

  if unseen_ids.empty?
    session[:shown_link_ids] = []
    redirect_to show_random_links_path, notice: "You've seen all links. Restarting..."
    return
  end

  @link = Link.find(unseen_ids.sample)
  session[:shown_link_ids] << @link.id
end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/ views
 
  # GET /links/1/edit
  def edit
  end
  
def visit
  @link = Link.find(params[:id])

  if user_signed_in?
    # Create a view record
    LinkView.create(user: current_user, link: @link, viewed_at: Time.current)

    # Add link value to user's balance
    reward = @link.value || 0
    current_user.increment!(:balance, reward)
  end

  redirect_to @link.url, allow_other_host: true
end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params.merge(admin: current_admin))


    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_path, status: :see_other, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.expect(link: [ :url, :admin_id ])
    end
end
