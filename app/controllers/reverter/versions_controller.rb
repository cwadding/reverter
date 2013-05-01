module Reverter
  class VersionsController < ApplicationController
    # before_filter :authenticate_user!
    # authorize_resource
    
    def revert
      options= {:class => "btn btn-mini btn-danger", form_class: "pull-right"}
      @version = Version.find(params[:id])
      if @version.reify
        @version.reify.save!
      else
        @version.item.destroy
      end
      if params[:redo] == "true"
        link_name =  I18n.t("reverter.links.undo")
        flash_path = "reverter.flash.redo.one"
      else
        link_name =  I18n.t("reverter.links.redo")
        flash_path = "reverter.flash.undo.one"
      end
      if @version.next.nil?
        redirect_to :back, :notice => I18n.t(flash_path, verb: @version.event, link: "")
      else
        link = view_context.button_to(link_name, revert_version_path(@version.next, :redo => !params[:redo]), options)
        redirect_to :back, :notice => I18n.t(flash_path, verb: @version.event, link: link)
      end
      
    end  
  end
end