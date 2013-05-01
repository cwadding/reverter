class PostsController < ApplicationController

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:notice] = flash_notice(@post)
		end
		render :nothing => true
	end

	def multiple
		@posts = Post.find(params[:posts].keys)
		@posts.map(&:destroy)
		flash[:notice] = flash_notice(@posts)
		render :nothing => true
	end
    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
      	params.permit(:post, :posts)
      end
end
