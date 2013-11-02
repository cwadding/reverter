class PostsController < ApplicationController

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:notice] = flash_notice(@post)
		end
		render :nothing => true
	end

	def multiple
		@posts = Post.find(multiple_params.keys)
		@posts.map(&:destroy)
		flash[:notice] = flash_notice(@posts)
		render :nothing => true
	end
    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def multiple_params
      	params.require(:posts).permit!
      end
      def post_params
      	params.require(:post).permit!
      end      
end
