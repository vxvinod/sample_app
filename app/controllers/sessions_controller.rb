class SessionsController < ApplicationController

	def new
	end

	def destroy
	end
	
	def create 
		user=User.find_by_email(params[:session][:email].downcase)
		if user&& user.authenticate(params[:session][:password])
			render User.new
		else
		flash.now[:error]="Invalid email/password combination"
		render'new'
		end	
	end
end
