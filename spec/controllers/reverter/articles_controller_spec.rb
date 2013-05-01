require 'spec_helper'

describe ArticlesController do

	describe "#flash_notice" do
		context "with collection" do
			context "without paper trail" do
				before(:each) do
					@article1 = Article.create(:name => "article1")
					@article2 = Article.create(:name => "article2")
				end
				it "returns a flash message" do
					put :multiple, {:articles => {@article1.id => {name: "hello"}, @article2.id => {name: "world"}}}, {}
					controller.flash[:notice].should_not have_selector("input[type=\"submit\"][value=\"#{I18n.t("reverter.links.undo")}\"]")
					controller.flash[:notice].should have_content(I18n.t("reverter.flash.notice.other", :model => "Articles", :verb => "destroyed", :count => 2))
				end
			end
		end
		context "with model" do
			context "without paper trail" do
				it "returns a flash message" do
					post :create, {:article => {name: "hello"}}, {}
					controller.flash[:notice].should_not have_selector("input[type=\"submit\"][value=\"#{I18n.t("reverter.links.undo")}\"]")
					controller.flash[:notice].should have_content(I18n.t("reverter.flash.notice.one", :model => "Article", :verb => "created"))
				end
			end
		end
	end
end