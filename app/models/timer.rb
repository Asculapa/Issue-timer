class Timer < ApplicationRecord
  belongs_to :task
  belongs_to :user

  has_and_belongs_to_many :periods
end
