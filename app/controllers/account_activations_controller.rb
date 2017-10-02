require 'jwt'

class AccountActivationsController < ApplicationController
	JWT_SECRET = 'secret'
	JWT_ALGORITHM = 'HS256'
	JWT_EXP_DELTA_SECONDS = 20

	def edit
		user = User.find_by(email: params[:email])

		if user && !user.activated? && user.authenticated?(:activation, params[:id])
	  		user.activate
	  		payload = {
				'email': params[:email],             
			}
			token = JWT.encode(payload, JWT_SECRET, JWT_ALGORITHM)			
	  		render json: {code:true, token: token, email: params[:email], menssage: "Account for #{user.name} activated"}
	  		# redirect_to "localhost:9000/dashboards"
	  		# log_in user	  		
		else
	  		
		end
	end

	def resend_activation
		user = User.find_by(email: params[:email])
		user.new_activation_email
		redirect_to root_url
		flash[:success] = "Novo email enviado!"
	end

end
