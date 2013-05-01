require 'spec_helper'

describe PostsController do

	describe "#flash_notice" do
		context "with collection" do
			context "with paper trail" do
				before(:each) do
					@post1 = Post.create(:name => "post1")
					@post2 = Post.create(:name => "post2")
				end
				it "returns a flash message" do
					put :multiple, {:posts => {@post1.id => {name: "hello"}, @post2.id => {name: "world"}}}, {}
					controller.flash[:notice].should have_selector("input[type=\"submit\"][value=\"#{I18n.t("reverter.links.undo")}\"]")
					controller.flash[:notice].should have_content(I18n.t("reverter.flash.notice.other", :model => "Posts", :verb => "destroyed", :count => 2))
				end
			end
		end
		context "with model" do
			context "with paper trail" do
				it "returns a flash message" do
					post :create, {:post => {name: "hello"}}, {}
					controller.flash[:notice].should have_selector("input[type=\"submit\"][value=\"#{I18n.t("reverter.links.undo")}\"]")
					controller.flash[:notice].should have_content(I18n.t("reverter.flash.notice.one", :model => "Post", :verb => "created"))
				end
			end
		end
	end
end