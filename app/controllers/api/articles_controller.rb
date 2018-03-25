class Api::ArticlesController < Api::ApiController
  before_action :get_article, only: [:show,:update, :destroy]

  def get_article
    if !current_user.admin?
      @article = current_user.articles.find(params[:id])
    else
      @article=Article.find(params[:id])

    end
  end

  def index
    if !current_user.admin?
      articles = current_user.articles

    else

      articles=Article.all

    end
    render status: 200, json: articles.as_json(include: [:categories])
  end

  def show


    render json: @article.as_json(include: [:categories])

  end

  def create
    article=current_user.articles.new(article_params)
    article.user = current_user
    article.categories = set_categories
    if article.save
      render status: 200, json: {
          message: "Article created successfully",
          article: article,
          categories:article.categories}.to_json
    else
      render status: 422, json: {
          errors: article.errors }.to_json
    end
  end

  def update

    if @article.update(article_params)
      render status: 200, json: {
          message: "Article successfully updated",
          article: @article,
          categories: @article.categories
      }.to_json
    else
      render status: 422,json: {
          message: "The article could not be updated.",
          errors: @article.errors,
          article: @article
      }.to_json
    end
  end

  def destroy

    @article.destroy
    render status: 200, json: {
        message: "Article deleted successfully." }.to_json

  end

  private
  def article_params

    params.require(:article).permit(:title, :description)

  end

  def set_categories
    params[:category_ids].map {|x| Category.find(x)}
  end


end