class Transaction < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	validates :amount, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :less_than => 100000}

end
