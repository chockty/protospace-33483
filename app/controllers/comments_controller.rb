class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to(prototype_path(@comment.prototype.id))
    else
      @prototype = Prototype.find(@comment.prototype.id)
      # 直接ビューファイルを呼び出しにいこうとするため、再度どのprototypeかという情報を渡してやる必要がある。
      @comments = Comment.all.includes(:user) 
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
