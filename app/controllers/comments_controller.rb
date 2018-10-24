class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
 def create
   @post = Post.find(params[:post_id])
   @comment = @post.comments.create(comment_params)
   @comment.post_id = @post.id
   @comment.user_id = current_user.id
   if @comment.save(comment_params)
     redirect_to post_path(@post)
   else
     render 'new'
   end
 end

 def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.destroy
		redirect_to message_path(@message)
 end

 private
 def comment_params
   params.require(:comment).permit(:content)
 end
end
