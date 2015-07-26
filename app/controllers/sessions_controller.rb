class SessionsController < ApplicationController
	def new
		@topic = Topic.find(params[:topic_id])
		@session = Session.new
	end

	def create
		@session = Session.new(session_params)
		@session.tutee_id = current_user.id
		@topic = Topic.find(eval(params[:topic_id])[:value])
		@session.topics << @topic
		#TODO: make sure that this is correct in terms of adding a topic to session and vice versa
		if @session.save
			redirect_to "/sessions"
		else
			render 'new'
		end
	end

	def index
		@sessions = Session.where(tutee_id: current_user.id)
	end

	private
	def session_params
		params.require(:session).permit(:availability, :additional_info)
	end
end