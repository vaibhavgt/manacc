class CategoriesController < ApplicationController

	before_action :authenticate_user!
	before_action :set_user

	def index	 
		@categories = @user.categories
	end

	def create
		@category = @user.categories.build(category_params)
		@category.type = params[:type]
		if @category.save
			flash[:notice] = "#Created Successfully"
			redirect_to user_categories_path
		else
			flash[:notice] = "Error creating Category"
			render "new"
		end

	end

	def edit
		@category = @user.categories.find(params[:id])
	end

	def update
		@category = @user.categories.find(params[:id])
		if @category.update(category_params)
			flash[:notice] = "Category updated Successfully"
			redirect_to user_categories_path
		else
			flash[:notice] = "Error updating Category"
			render "index"
		end


	end

	def show
	end

	def new
		@category = @user.categories.build
	end

	def destroy
	end


private
	def set_user
		@user = current_user
	end

	def category_params
		params.require(:category).permit(:type, :source, :description)
	end

end
