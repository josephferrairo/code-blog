class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :likes

  def like_count
    self.likes.count
  end
end
