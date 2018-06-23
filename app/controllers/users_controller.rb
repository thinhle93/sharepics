class UsersController < ApplicationController
    def index

    end

    def dashboard
        if session[:userid] 
            @name = User.find(session[:userid]).user_name
        else
            @name = "Quest"
        end
        @posts = Post.all
    end

    def logout
        session.clear
        redirect_to '/'
    end
    def register
        user = User.create(user_params)
        
        if !user.valid?
            flash[:errors] = user.errors.full_messages
            redirect_to "/users/index"
        else            
            session[:userid] = user.id
            redirect_to "/users/dashboard"
        end
    end

    def login_process
        u = User.find_by(email: params[:email])
        
        if u && u.authenticate(params[:password])
            
            session[:userid] = u.id 
            redirect_to "/users/dashboard"
        else
            flash[:errors] = ["Invalid Information"]
            redirect_to "/users/index"
        end 
    end

    def newpost

    end

    def newpost_process
        newpost = Post.create(post_params)
        if !newpost.valid?
            flash[:errors] = newpost.errors.full_messages
            puts "==================="
            puts newpost.errors
            redirect_to "/newpost"
        else
            redirect_to "/users/dashboard"
        end
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end

    def post_params
        params.require(:post).permit(:image, :user_id, :description)
    end
end
