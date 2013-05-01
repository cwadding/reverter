class ArticlesController < ApplicationController
	def create
		@article = Article.new(article_params)
		if @article.save
			flash[:notice] = flash_notice(@article)
		end
		render :nothing => true
	end

	def multiple
		@articles = Article.find(params[:articles].keys)
		flash[:notice] = flash_notice(@articles)
		@articles.map(&:destroy)
		render :nothing => true
	end
    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def article_params
        params.permit(:article, :articles)
      end
end
