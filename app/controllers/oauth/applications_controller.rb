module Oauth
  class ApplicationsController < Doorkeeper::ApplicationsController
    before_filter :authenticate_user!

    def index
      @applications = current_user.oauth_applications
      @authorized_applications = Doorkeeper::Application.authorized_for(current_user)
    end

    # only needed if each application must have some owner
    def create
      @application       = Doorkeeper::Application.new(application_params)
      @application.owner = current_user if Doorkeeper.configuration.confirm_application_owner?
      if @application.save
        flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
        redirect_to oauth_application_url(@application)
      else
        render :new
      end
    end

    private

    def set_application
      @application = current_user.oauth_applications.find(params[:id])
    end
  end
end
