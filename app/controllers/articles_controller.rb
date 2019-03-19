class ArticlesController < ApplicationController
  # calls method on certain pages
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def new
    @article = Article.new
  end

  def edit
    set_article
  end

  def index
    @articles = Article.all
  end

  def create
    debugger
    @article = Article.new(article_params)
    # Hardcode user for now
    @article.user = User.first
    # Conventional syntax
    if @article.save
      flash[:success] = "Article was succefully created"
      redirect_to article_path(@article)
    else
      render 'new' # or :new
    end
  end

  def update
    set_article
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
    set_article
  end

  def destroy
    set_article
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
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
