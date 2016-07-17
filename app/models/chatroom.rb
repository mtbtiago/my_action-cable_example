class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :topic, presence: true, uniqueness: true, case_sensitive: false
  before_validation :sanitize, :slugify

  def to_param
    slug
  end

  def slugify
    self.slug = topic.downcase.tr(' ', '-')
  end

  def sanitize
    self.topic = topic.strip
  end
end
