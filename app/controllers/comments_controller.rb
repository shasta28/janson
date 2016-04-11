class CommentsController < ApplicationController

	before_action :authenticate_user!
	before_action :correct_user, only: :destroy

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			flash[:success] = "Comment added!"
			redirect_to_back_or_default
		else
			flash[:danger] = "Error: #{@comment.errors.full_messages.join('. ')}."
			redirect_to_back_or_default
		end
	end

	def destroy
		Comment.find(params[:id]).delete
		flash[:success] = "Comment deleted."
		redirect_to_back_or_default
	end

	private

		def comment_params
			params.require(:comment).permit(:post_id, :user_id, :body)
		end

		def correct_user
			@comment = current_user.comments.find_by(id: params[:id])
			redirect_to root_path if @comment.nil?
		end

end