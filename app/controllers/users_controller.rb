class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.points = 0
    @user.coin = "item: :coin, denomination: 0.25\nitem: :coin, denomination: 0.25\nitem: :coin, denomination: 0.25"
    @user.die = "item: :die, sides: 6, colour: :white\nitem: :die, sides: 6, colour: :white\nitem: :die, sides: 6, colour: :white\n"

    respond_to do |format|
      if @user.save      
        format.html { redirect_to root_path, notice: "User was successfully signed up." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy

    # Sign out user before destroying their account
    session[:user_id] = nil

    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Users account was successfully signed out and deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email_address, :password)
    end
end
