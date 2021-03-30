class ArticlesController < ApplicationController
  #do this action before doing only these four methods where it's required
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
    @article
  end

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def create
    @article = Article.new(article_params)
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
    @article
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
    params.require(:article).permit(:title, :description)
  end

end
