class Admin::OrganizationsController < Admin::BaseController
  has_filters %w{pending all verified rejected}, only: :index

  load_and_authorize_resource except: [:search, :new, :create]

  def index
    @organizations = @organizations.send(@current_filter)
    @organizations = @organizations.includes(:user)
                                   .order('users.created_at', :name, 'users.email')
                                   .page(params[:page])
  end

  def search
    @organizations = Organization.includes(:user)
                                 .search(params[:term])
                                 .order('users.created_at', :name, 'users.email')
                                 .page(params[:page])
  end

  def verify
    @organization.verify
    redirect_to request.query_parameters.merge(action: :index)
  end

  def reject
    @organization.reject
    redirect_to request.query_parameters.merge(action: :index)
  end

  def new
    @user = User.new do |user|
      user.build_organization
    end
  end

  def create
    @user = User.new(organization_params)
    if @user.save
            redirect_to new_admin_organization_path, notice: t("admin.organizations.index.success")
    else
      render :new
    end
  end

  private
    def organization_params
      params[:user][:document_type] = "1"
      params[:user][:password] = params[:user][:document_number]
      params[:user][:password_confirmation] = params[:user][:document_number]
      params[:user][:terms_of_service] = "1"
      params[:user][:organization_attributes][:responsible_name] = params[:user][:username]
      params.require(:user).permit(:document_number, :document_type, :username, :email, :password, :phone_number,
                                   :password_confirmation, :terms_of_service,
                                   organization_attributes: [:name, :responsible_name])
    end

end
