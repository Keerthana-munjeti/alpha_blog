class UsersController < ApplicationController
    before_action:set_user , only: [:show, :edit, :update, :destroy]
    before_action:require_user, only: [:edit, :destroy, :update]
    before_action:require_same_user, except: [:index, :show, :new]
    def new
        @user=User.new
    end

    def edit
       # @user=User.find(params[:id])
    
    end

    def index
        @users=User.all
    end
  

    def destroy
        @user.destroy
        session[:user_id] = nil
        session[:notice] = "Account deleted successfully"
        redirect_to article_path
    end


    def show
       # @user=User.find(params[:id])
        @articles = @user.articles
    end

        def update
           #  @user= User.find(params[:id])
             if @user.update(username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
                flash[:notice]= "The user is updated successfully"
                 redirect_to users_path
             else
               render 'edit'
            end
          end
            

    def create
        @user=User.new(params.require(:user).permit(:username,:email,:password))
        if @user.save
            session[:user_id]=@user.id

            flash[:notice] = "New user   signed up successfully!"
            redirect_to '/'
        else
            render 'new'
        end
    end

    private

    def set_user
        begin
           @user=User.find(params[:id])
        rescue 
            render plain: "user  with given id not found"
        end
    end

    def require_same_user
        if  current_user != @user
            flash[:error] = "you are not allowed to change others details"
            redirect_to @user
        end
end


end