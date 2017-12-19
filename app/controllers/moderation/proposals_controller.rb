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

  private

    def resource_model
      Proposal
    end
end
