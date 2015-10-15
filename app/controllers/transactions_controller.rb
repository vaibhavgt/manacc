class TransactionsController < ApplicationController

#type = 1 is for IncomeTransaction
#type = 2 is for expensetransaction
  before_action :authenticate_user!
  def add
  end

  def new
    @type = (params[:type]).to_i
    set_category(@type)
  	@transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id
    @transaction.type = (((params[:type]).to_i) == 1)? "IncomeTransaction" : "ExpenseTransaction"
    set_balance(@transaction, (params[:type]).to_i)
    if @transaction.save
      flash[:notice] = "#{transaction_params[:amount]}rs sucessfully saved"
      redirect_to  action: :index
    else
      flash[:alert] = "Error saving... Remember to keep amount between 0 and 100000 and do not forget to fill up the amount"
      render 'add'
    end
  end


  def index
    @transactions = current_user.transactions.order(created_at: :desc).limit(10)
  end



private
 
  def set_user
  	current_user
  end 

  def set_category(type)
  	if (type == 1)
  		@cat_arr= set_user.categories.where(type: "IncomeCategory")
  	elsif(type == 2)
  		@cat_arr = set_user.categories.where(type: "ExpenseCategory")
    end
  end

  def transaction_params
      params.require(:transaction).permit(:type, :amount, :category_id)
  end

  def set_balance(trans,type)
  if current_user.transactions.empty?
    trans.current_balance =  transaction_params[:amount].to_f
  else
    if (type == 1)
      trans.current_balance =   current_user.transactions.order(created_at: :asc).last.current_balance + transaction_params[:amount].to_f
    elsif(type == 2)
      trans.current_balance =   current_user.transactions.order(created_at: :asc).last.current_balance - transaction_params[:amount].to_f
    end
  end
  end
end
