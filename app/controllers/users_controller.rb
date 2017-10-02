class UsersController < ApplicationController
    
        def new
            @user = User.new
        end
    
        def show
            @user = User.find(params[:id])
        end
    
        def destroy
            username = User.find(params[:id]).name
            if User.find(params[:id]).destroy
                render json: {code: true, message: "User #{username} destroyed" }
            else
                render json: {code: false, message: "User #{username} NOT destroyed"}
            end
    
        end
    
        def create	
            
            @user = User.new(user_params)
    
            if @user.save
                puts "saved!"
                @user.send_activation_email							
                activation = "http://localhost:4200/account/activation?token=#{@user.activation_token}&email=#{@user.email}"
                render json: {code: true, message: "User created", activation: activation}			
            else
                render json: {code: false, message: "User NOT created"}
            end
        end
    
        private
    
        def user_params
          params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
    
    end
    