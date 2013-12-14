class UsersController < ApplicationController

 before_action :signed_in_user, only: [:index, :edit, :update]
 before_action :correct_user,   only: [:edit, :update]
 
  def index
     @users = Party.paginate(page: params[:page])
  end
  
  def show
    @user = Party.find(params[:id])
  end
  
  def new
  	@party = Party.new
  end
  
  def create
    @party = Party.new(party_params)
    if @party.save
      # Handle a successful save.
      sign_in @party
      flash[:success] = "Welcome to the Shiatsu Wijzer"
      redirect_to  user_path(@party)
    else
      render 'new'
    end
  end
  
   def edit
    @party = Party.find(params[:id])
  end
  
  def update
    @party = Party.find(params[:id])
    if @party.update_attributes(party_params)
      flash[:success] = "Profile updated"
      redirect_to  user_path(@party)
    else
      render 'edit'
    end
  end
  
  private

    def party_params
      params.require(:party).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    def signed_in_user
    		#redirect_to signin_url, notice: "Please sign in." unless signed_in?
        store_location
		unless signed_in?
  			flash[:notice] = "Please sign in."
		  	redirect_to signin_url
		end
  end
  
    def correct_user
      @user = Party.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
  
end
