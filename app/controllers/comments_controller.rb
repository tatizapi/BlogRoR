class CommentsController < ApplicationController
	def new
		@comment = Comment.new(parent_id: params[:comment_id])
		@article = Article.find(params[:article_id])
	end

	def create
		@article = Article.find(params[:article_id])
		#@comment = @article.comments.create(comment_params)

		if params[:comment][:parent_id].to_i > 0
	    parent = Comment.find_by_id(params[:comment].delete(:parent_id)) # ??
	    @comment = parent.children.build(comment_params)
			@comment.user = current_user
			@comment.article = @article
			@comment.save
	  else
			@comment = @article.comments.new(comment_params)
		  @comment.user = current_user
    	@comment.save
	    #@comment = @article.comments.create(comment_params)
	  end

		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article)
	end

	def edit
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
	end

	def update
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])

		if @comment.update(comment_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:commenter, :body)
		end
end
