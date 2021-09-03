class SessionsController < ApplicationController
   
     def new 
     end

     def create 
        user = User.find_by(email:params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id]=user.id
            flash[:notice] = "User logged in successfully!"
            redirect_to articles_path
        else
            flash.now[:alert]= "Incorrect credentials"
            render 'new'
        end
    end
     
      def destroy
        session[:user_id] = nil
        flash.now[:notice]=  "logged out successfully"
        redirect_to root_path
    end
end
