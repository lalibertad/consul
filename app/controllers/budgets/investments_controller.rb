module Budgets
  class InvestmentsController < ApplicationController
    include FeatureFlags
    include CommentableActions
    include FlagActions

    before_action :authenticate_user!, except: [:index, :show]

    load_and_authorize_resource :budget
    load_and_authorize_resource :investment, through: :budget, class: "Budget::Investment"

    before_action -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }
    before_action :load_ballot, only: [:index, :show]
    before_action :load_heading, only: [:index, :show]
    before_action :set_random_seed, only: :index
    before_action :load_categories, only: [:index, :new, :create]
    before_action :set_default_budget_filter, only: :index

    feature_flag :budgets

    has_orders %w{most_voted newest oldest}, only: :show
    has_orders ->(c) { c.instance_variable_get(:@budget).investments_orders }, only: :index
    has_filters %w{not_unfeasible feasible unfeasible unselected selected}, only: [:index, :show, :suggest]

    invisible_captcha only: [:create, :update], honeypot: :subtitle, scope: :budget_investment

    helper_method :resource_model, :resource_name
    respond_to :html, :js

    def index
      @investments = investments.page(params[:page]).per(10).for_render

      @investment_ids = @investments.pluck(:id)
      load_investment_votes(@investments)
      @tag_cloud = tag_cloud
    end

    def new
      @proposals = load_proposals_all
    end

    def show
      @commentable = @investment
      @comment_tree = CommentTree.new(@commentable, params[:page], @current_order)
      @related_contents = Kaminari.paginate_array(@investment.relationed_contents).page(params[:page]).per(5)
      set_comment_flags(@comment_tree.comments)
      load_investment_votes(@investment)
      @investment_ids = [@investment.id]
    end

    def create
      if valid_head.to_i > 0
        save_resource @budget.headings.find(valid_head)
      end
      @proposals = load_proposals_all
      render :new
    end

    def destroy
      @investment.destroy
      redirect_to user_path(current_user, filter: 'budget_investments'), notice: t('flash.actions.destroy.budget_investment')
    end

    def vote
      @investment.register_selection(current_user)
      load_investment_votes(@investment)
      respond_to do |format|
        format.html { redirect_to budget_investments_path(heading_id: @investment.heading.id) }
        format.js
      end
    end

    def suggest
      @resource_path_method = :namespaced_budget_investment_path
      @resource_relation    = resource_model.where(budget: @budget).apply_filters_and_search(@budget, params, @current_filter)
      super
    end

    private

      def load_proposals_all
        @proposals = Proposal.successful.order(cached_votes_up: :desc).where(status: false)
      end

      def valid_head
        params[:budget_investment][:heading_id].present? ? params[:budget_investment][:heading_id] : 0
      end

      def save_resource(heading)
        if params[:proposal_ids].present?
          params[:proposal_ids].each do |id|
            @proposal = Proposal.find(id)
            ActiveRecord::Base.transaction do
              @investment = Budget::Investment.new
              @investment.terms_of_service = "1"
              @investment.author_id = @proposal.author_id
              @investment.administrator_id = current_user.id
              @investment.title = @proposal.title
              txt = "<p>Tipo de propuesta: <strong>" + @proposal.tipe + "</strong></p>"
              if @proposal.level.present?
                txt += "<p>Nivel de estudio del proyecto: <strong>" + @proposal.level + "</strong></p>"
              end
              @investment.description = txt + @proposal.description
              @investment.external_url = @proposal.external_url
              @investment.cached_votes_up = @proposal.cached_votes_up
              @investment.comments_count = @proposal.comments_count
              @investment.confidence_score = @proposal.confidence_score
              @investment.created_at = @proposal.created_at
              @investment.heading_id = heading.id
              @investment.responsible_name = @proposal.responsible_name
              @investment.budget_id = @budget.id
              @investment.group_id = heading.group_id
              @investment.geozone_id = @proposal.geozone_id
              @investment.location = @proposal.geozone.present? ? @proposal.geozone.name : ""
              @investment.community_id = @proposal.community_id
              @investment.skip_map = "1"
              @proposal.status = true
              if @investment.save
                @proposal.save
                save_image @proposal.id, @investment.id
                save_document @proposal.id, @investment.id
                save_map @proposal.id, @investment.id
                save_tag @proposal.id, @investment.id
                save_comments @proposal.id, @investment.id
                Mailer.budget_investment_created(@investment).deliver_later
              end
            end
          end
        end
      end

      def save_image(p, i)
        @images = Image.where(imageable_id: p).where(imageable_type: "Proposal")
        if @images.present?
          @images.each do |image|
            image.imageable_id = i
            image.imageable_type = "Budget::Investment"
            image.save
          end
        end
      end

      def save_document(p, i)
        @documents = Document.where(documentable_id: p).where(documentable_type: "Proposal")
        if @documents.present?
          @documents.each do |document|
            document.documentable_id = i
            document.documentable_type = "Budget::Investment"
            document.save
          end
        end
      end

      def save_map(p, i)
        @maps = MapLocation.where(proposal_id: p)
        if @maps.present?
          @maps.each do |map|
            map.investment_id = i
            map.save
          end
        end
      end

      def save_tag(p, i)
        @tags = ActsAsTaggableOn::Tagging.where(taggable_id: p).where(taggable_type: "Proposal")
        if @tags.present?
          @tags.each do |tag|
            tag.taggable_id = i
            tag.taggable_type = "Budget::Investment"
            tag.save
          end
        end
      end

      def save_comments(p, i)
        @comments = Comment.where(commentable_id: p).where(commentable_type: "Proposal")
        if @comments.present?
          @comments.each do |comment|
            comment.commentable_id = i
            comment.commentable_type = "Budget::Investment"
            comment.save
          end
        end
      end

      def resource_model
        Budget::Investment
      end

      def resource_name
        "budget_investment"
      end

      def load_investment_votes(investments)
        @investment_votes = current_user ? current_user.budget_investment_votes(investments) : {}
      end

      def set_random_seed
        if params[:order] == 'random' || params[:order].blank?
          seed = params[:random_seed] || session[:random_seed] || rand(-100000..100000)
          params[:random_seed] ||= Float(seed) rescue 0
        else
          params[:random_seed] = nil
        end
      end

      def investment_params
        params.require(:budget_investment).permit(:heading_id)
      end

      def load_ballot
        query = Budget::Ballot.where(user: current_user, budget: @budget)
        @ballot = @budget.balloting? ? query.first_or_create : query.first_or_initialize
      end

      def load_heading
        if params[:heading_id].present?
          @heading = @budget.headings.find(params[:heading_id])
          #@assigned_heading = @ballot.try(:heading_for_group, @heading.try(:group))
        end
      end

      def load_categories
        @categories = ActsAsTaggableOn::Tag.category.order(:name)
      end

      def tag_cloud
        TagCloud.new(Budget::Investment, params[:search])
      end

      def investments
        if @current_order == 'random'
          @investments.apply_filters_and_search(@budget, params, @current_filter)
                      .send("sort_by_#{@current_order}", params[:random_seed])
        else
          @investments.apply_filters_and_search(@budget, params, @current_filter)
                      .send("sort_by_#{@current_order}")
        end
      end

  end

end
