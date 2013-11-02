require 'spec_helper'

describe Reverter::VersionsController, :versioning => true do

  def valid_session
    {}
  end
  
  describe "POST revert" do
    before(:each) do
      @post = Post.create(name: 'foo')
      controller.request.env['HTTP_REFERER'] = '/posts/new'
    end
    context "from a destroy or update" do
      before(:each) do
        @post = Post.last
        @post.name = "NewRuleName"
        @post.save
        @version = PaperTrail::Version.last
      end
      it "assign the requested version @version" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :revert, {:id => @version.to_param, :use_route => :reverter}, valid_session
        assigns(:version).should eq(@version)
      end
      
      it "saves the reverted version" do
        Post.any_instance.should_receive(:save!)
        post :revert, {:id => @version.to_param, :use_route => :reverter}, valid_session
      end

      it "redirects back to the previous page" do
        post :revert, {:id => @version.to_param, :use_route => :reverter}, valid_session
        response.should redirect_to('/posts/new')
      end
      
      context "after an undo" do
        it "sets the flash notice" do
          post :revert, {:id => @version.to_param, :redo => "true", :use_route => :reverter}, valid_session
          controller.flash[:notice].should include(I18n.t("reverter.flash.redo.one", verb: @version.event, link: ""))
        end
        
        it "returns a link to redo" do
          post :revert, {:id => @version.to_param, :redo => "true", :use_route => :reverter}, valid_session
          controller.flash[:notice].should have_selector("input[type=\"submit\"][value=\"#{I18n.t("reverter.links.undo")}\"]")
        end
      end
      
      context "before an undo" do
        it "sets the flash notice" do
          post :revert, {:id => @version.to_param, :redo => "false", :use_route => :reverter}, valid_session
          controller.flash[:notice].should include(I18n.t("reverter.flash.undo.one", verb: @version.event, link: ""))
        end
        
        it "returns a link to undo" do
          post :revert, {:id => @version.to_param, :redo => "false", :use_route => :reverter}, valid_session
          controller.flash[:notice].should have_selector("input[type='submit'][value='#{I18n.t("reverter.links.redo")}']")
        end
      end
    end
    
    context "from a create" do
      before(:each) do
        @version = PaperTrail::Version.last
      end
      it "destroys the reverted version" do
        Post.any_instance.should_receive(:destroy)
        post :revert, {:id => @version.to_param, :use_route => :reverter}, valid_session
      end
    end
  end
  
end
