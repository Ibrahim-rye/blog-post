class PostMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def post_created(post)
    @post = post
    mail(to: @post.user.email, subject: 'Your post has been created!')
  end
end
