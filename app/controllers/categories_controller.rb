class CategoriesController < ApplicationController
    #before any methods are activated, run the require admin method
    #but exclude the index and show methods
    before_action :require_admin, except: [:index, :show]

    def show
        @category = Category.find(params[:id])
        @articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end

    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    def new
        @category = Category.new
    end

    def create
        #make a new category instance, and accept the permitted params
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category was successfully created"
            #if successful, redirect to the category show page 
            redirect_to @category
        else
            render 'new'
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id]) 
        if @category.update(category_params)
            flash[:notice] = "Category name updated successfully!"
            redirect_to @category
        else
            render 'edit'
        end
    end


    private

    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
        #if NOT user logged in and current user is admin, send an error flash message and redirect to index
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "Only admins can perform that action"
            redirect_to categories_path
        end
    end
    
end