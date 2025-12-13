# frozen_string_literal: true

class ComponentsController < ApplicationController
  helper Aeros::ApplicationHelper
  before_action :load_components

  def index
  end

  def show
    @component = params[:id]
    render "components/#{@component}"
  end

  private

  def load_components
    @components = Dir.glob(Rails.root.join("app/views/components/*.html.erb")).map do |f|
      File.basename(f, ".html.erb")
    end.reject { |c| c == "index" }.sort
  end
end
