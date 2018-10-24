class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_post
  before_action :find_comment, only: [:destroy]

 def create
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
    @comment.destroy
    redirect_to post_path(@post)
 end

 private
 def comment_params
   params.require(:comment).permit(:content)
 end

 def find_post
   @post = Post.find(params[:post_id])
 end

 def find_comment
   @comment = @post.comments.find[params[:id]]
 end
end
