class Api::CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :message_id, :parent_id, :league_id)
  end
end
