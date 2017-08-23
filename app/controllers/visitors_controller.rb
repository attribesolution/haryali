class VisitorsController < ApplicationController
	before_action :authenticate_user! 

	def index
		if (current_user)
			@leads = Lead.find_by_email(current_user.email)
		end
	end
end
