class VisitorsController < ApplicationController
	before_action :authenticate_user! 

	def index
		if (current_user)
			@leads = Lead.where(email: current_user.email)
		end
	end
end
