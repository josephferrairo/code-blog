class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_one :profile
  validates :first_name, :last_name, presence: true
  after_create :create_profile

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def create_profile
    Profile.new(user: self)
  end
end
