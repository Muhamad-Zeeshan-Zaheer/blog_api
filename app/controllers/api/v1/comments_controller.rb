class Api::V1::CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:show, :destroy]

  def index
    render json: @article.comments
  end

  def show
    render json: @comment
  end

  def create
    comment = @article.comments.new(comment_params)

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: { message: "Comment deleted" }
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Article not found" }, status: :not_found
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Comment not found" }, status: :not_found
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
