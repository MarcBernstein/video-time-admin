class Message < ActiveRecord::Base
  validates :minutes, presence: true, length: { minimum: 1 }, numericality: { only_integer: true }
  validates :reason, presence: true, length: { minimum: 1 }
  validates :from, presence: true, length: { minimum: 1 }
end
