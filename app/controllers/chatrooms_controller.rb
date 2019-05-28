class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show, :edit, :update, :destroy]
  layout "chatbox"
  # GET /chatrooms
  # GET /chatrooms.json
  def index
    @chatrooms = Chatroom.where("chatroom_type=1")
    respond_to do |format|
      format.js{render partial: 'chatroom_router.js.erb',locals:{from: :index}}
      format.html{render 'index.html.erb'}
    end
  end

  # GET /chatrooms/1
  # GET /chatrooms/1.json
  def show
    @messages=@chatroom.messages.order(created_at: :desc).limit(100).reverse
    respond_to do |format|
      format.js{render partial: 'chatroom_router.js.erb',locals:{from: :show}}
      format.html{render 'show.html.erb'}
    end
  end

  # GET /chatrooms/new
  def new
    @chatroom = Chatroom.new
  end

  # GET /chatrooms/1/edit
  def edit
  end

  def all_users
    @users = User.all-[current_user]
    respond_to do |format|
      format.js{render partial: 'chatroom_router.js.erb',locals:{from: :all_users}}
    end
  end
  # POST /chatrooms
  # POST /chatrooms.json
  def create
    @chatroom = Chatroom.new(chatroom_params)
    @chatroom.created_by=current_user.id
    respond_to do |format|
      if @chatroom.save
        @chatroom_user=@chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
        format.json { render :show, status: :created, location: @chatroom }
      else
        format.html { render :new }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chatrooms/1
  # PATCH/PUT /chatrooms/1.json
  def update
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @chatroom }
      else
        format.html { render :edit }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1
  # DELETE /chatrooms/1.json
  def destroy
    @chatroom.destroy
    respond_to do |format|
      format.html { redirect_to chatrooms_url, notice: 'Chatroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_users_chatroom
    params[:name]=(params[:user_id].to_i<current_user.id) ? "#{params[:user_id]}_#{current_user.id}" : "#{current_user.id}_#{params[:user_id]}"
    params[:chatroom_type]=0
    @chatroom=Chatroom.where(name: params[:name],chatroom_type: params[:chatroom_type]).first_or_create
    redirect_to @chatroom
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chatroom_params
      params.require(:chatroom).permit(:name, :chatroom_type)
    end
end
