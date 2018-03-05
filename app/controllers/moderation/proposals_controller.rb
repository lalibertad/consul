class Moderation::ProposalsController < Moderation::BaseController
  include ModerateActions
  include CommentableActions
  include FeatureFlags

  has_filters %w{pending_flag_review all with_ignored_flag}, only: :index
  has_orders %w{confidence_score flags created_at}, only: :index

  feature_flag :proposals

  before_action :load_resources, only: [:index, :moderate]

  load_and_authorize_resource

  def index_customization
    @resources = @resources.where(status: false)
  end

  def show
  end

  def update
    if @proposal.update(proposal_params)
      @proposal.send_unfeasible_email
      redirect_to moderation_proposals_path
    else
      render :show
    end
  end

  private

    def resource_model
      Proposal
    end

    def proposal_params
      params[:proposal][:status] = true
      params.require(:proposal).permit(:rejection_description, :status)
    end

end
