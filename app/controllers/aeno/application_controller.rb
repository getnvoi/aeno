module Aeno
  class ApplicationController < ActionController::Base
    # Generic confirm dialog endpoint
    # Usage:
    #   <%= link_to "Delete", aeno.confirm_path(
    #         title: "Delete Item?",
    #         message: "This cannot be undone.",
    #         url: item_path(item),
    #         method: "delete"
    #       ),
    #       data: { turbo_frame: "dialogs-container" } %>
    def confirm
      @title = params[:title] || "Confirm"
      @message = params[:message] || "Are you sure?"
      @confirm_url = params[:url]
      @confirm_method = params[:method] || "delete"
      @confirm_text = params[:confirm_text] || "Confirm"
      @cancel_text = params[:cancel_text] || "Cancel"
      @variant = params[:variant] || "destructive"

      respond_to do |format|
        format.turbo_stream { render "confirm" }
      end
    end
  end
end
