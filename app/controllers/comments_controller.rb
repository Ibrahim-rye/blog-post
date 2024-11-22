class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    Rails.logger.debug("User ID: #{current_user.id}")

    if @comment.save
      # Broadcast the comment to the post's comments channel for live updates
      CommentsChannel.broadcast_to(
        @post,
        comment: render_comment(@comment)
      )
      # Respond to the request (AJAX)
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
        format.js   # This is to handle the AJAX response
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), alert: 'Failed to create comment.' }
        format.js   # Handle AJAX errors
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def render_comment(comment)
    # This method renders the comment in a partial to send to the channel.
    ApplicationController.render(
      partial: 'comments/comment',
      locals: { comment: comment }
    )
  end
end
