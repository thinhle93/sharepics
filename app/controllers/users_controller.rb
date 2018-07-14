class UsersController < ApplicationController
    def index

    end

    def dashboard
        if session[:userid] 
            @name = User.find(session[:userid]).user_name
        else
            @name = "Guest"
        end
        @posts = Post.all.paginate(page: params[:page], per_page: 4)
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
           
            redirect_to "/newpost"
        else
            redirect_to "/users/dashboard"
        end
    end

    def comment
        @post = Post.find(params[:id])
        @comments = @post.comments
    end

    def pro_comment
        newcomment = Comment.create(comment_params)
        if !newcomment.valid?
            flash[:errors] = newcomment.errors.full_messages
        end
        
        redirect_to "/users/comment/#{params[:postid]}"
        
    end

    def delete_post
        post = Post.find(params[:postid])
        post.destroy
        post.save
        redirect_to "/"
    end

    def editpost
        @post = Post.find(params[:editpost_id])
        p "==========="
        p @post.id
    end

    def editpost_process
        post = Post.find(params[:editpost_id])
        post.description = params[:editpost_description]
        post.save
        redirect_to "/users/comment/#{post.id}"
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end

    def post_params
        params.require(:post).permit(:image, :user_id, :description)
    end

    def comment_params
        params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
