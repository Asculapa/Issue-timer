class Task < ApplicationRecord
  belongs_to :service
  belongs_to :project

  has_many :timers
  has_and_belongs_to_many :users
end
