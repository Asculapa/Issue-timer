class Task < ApplicationRecord
  belongs_to :service

  has_many :timers
  has_and_belongs_to_many :users
end
