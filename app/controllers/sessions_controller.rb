require 'jwt'

class SessionsController < ApplicationController

	JWT_SECRET = 'secret'
	JWT_ALGORITHM = 'HS256'
	JWT_EXP_DELTA_SECONDS = 20

	def new
		msg = {message: "OK"}
		render json: msg 					
	end

	def create		
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			payload = {
				'user_id': user.name,             
			}
			token = JWT.encode(payload, JWT_SECRET, JWT_ALGORITHM)
			render json: {token: token}
		end
                   
	end

	def destroy
	end
end
