class Category < ActiveRecord::Base

	belongs_to :user
	has_many :transactions

	validates :source, presence: true
	validates :source, length: { minimum: 5 }
	validates :description, length: { minimum: 10}, allow_blank: true
end
