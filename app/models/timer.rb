class Timer < ApplicationRecord
  belongs_to :task

  has_many :time_period
end
