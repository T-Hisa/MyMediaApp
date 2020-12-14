class CommentsController < ApplicationController
  

  def create
    article = Article.find(comment_params[:article_id])
    comment = Comment.new(comment_params)
    comment.user_id = @current_user.id
    if comment.save
      redirect_to article_path(article), flash: {
        success: "コメントを投稿しました"
      }
    else
      redirect_back fallback_location: article_path(article), flash: {
        error: comment.errors.full_messages
      }
    end
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :article_id)
    end
end
