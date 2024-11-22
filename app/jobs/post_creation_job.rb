class PostCreationJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    # Send an email to the post's user
    post = Post.find(post_id)
    PostMailer.post_created(post).deliver_now
  end
end
