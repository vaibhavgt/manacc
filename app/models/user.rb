class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable , :trackable and :omniauthable
  after_create :make_default_categories

  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 3}


  def make_default_categories
  	Category.create!(source: "others", description: "This is a default category and should be used if the user wants to hide income source", user_id: self.id, type: "IncomeCategory")
  	Category.create!(source: "others", description: "This is a default category and should be used if the user wants to hide expense source", user_id: self.id, type: "ExpenseCategory")
  end
  
    
end
