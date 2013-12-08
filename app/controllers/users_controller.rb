class UsersController < ApplicationController

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
  
  private

    def party_params
      params.require(:party).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
end
