class CommentsChannel < ApplicationCable::Channel
  def subscribed
    # stream from a specific post's comments
    stream_for Post.find(params[:post_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_comment(data)
    post = Post.find(params[:post_id])
    comment = post.comments.create(content: data['content'], user: current_user)
    # Broadcast the new comment to all subscribers
    CommentsChannel.broadcast_to(post, comment: render_comment(comment))
  end

  private

  def render_comment(comment)
    ApplicationController.renderer.render(partial: 'comments/comment', locals: { comment: comment })
  end
end
