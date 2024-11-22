class Post < ApplicationRecord
  has_many :categorizations
  has_many :categories, through: :categorizations

  validates :title, presence: true

  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy

  after_create :send_creation_email

  private

  def send_creation_email
    PostCreationJob.perform_later(self.id)
  end

end
