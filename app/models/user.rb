class User < ApplicationRecord
  has_secure_password
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :username, :email

  has_and_belongs_to_many :tasks
  has_many :timers

  def serializable_hash(options = {})
    options[:except] ||= [:password_digest]
    super(options)
  end
end
