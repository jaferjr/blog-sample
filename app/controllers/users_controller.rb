class UsersController < ApplicationController

    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_user, only: [:update, :edit]
    before_action :require_same_user, only: [:update, :edit]

    def index
        @users = User.all
    end
    

    def show
        @articles = @user.articles
    end
    

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user_id
            flash[:notice] = "Welcome to Apha Blog #{@user.username}" 
            redirect_to articles_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your account was successfully updated"
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    

    private

    def user_params
     params.require(:user).permit(:username, :password, :email)  
    end

    def set_user
        @user = User.find(params[:id]) 
    end

    def require_same_user
        if set_user != current_user
            flash[:alert] = 'Mexa só no que é seu!'
            redirect_to @user
        end
    end
    
    
    
end
    