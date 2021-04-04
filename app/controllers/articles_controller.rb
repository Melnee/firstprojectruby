class ArticlesController < ApplicationController
  #do this action before doing only these four methods where it's required
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # call the require user method from application controller except for the show and index methods
  before_action :require_user, except: [:show, :index]
  #call the require same user method only for for edit update and destroy actions
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @article
  end

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def create
    @article = Article.new(article_params)
    #use the helper method from application_helper
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article successfully created!"
      redirect_to @article
    else
      render 'new'
    end
  end
    
  def new
    @article = Article.new
  end

  def edit
    @article
  end

  def update
    byebug
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article
    @article.destroy
    redirect_to articles_path
  end

  private
    
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  #require the same user as the author in order to edit or delete
  def require_same_user
    if current_user != @article.user && !current_user.admin
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end
end
