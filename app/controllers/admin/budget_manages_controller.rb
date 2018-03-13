class Admin::BudgetManagesController < Admin::BaseController

  before_action :load_budget
  before_action :load_heading
  before_action :load_proposals

  def create
    @failure = seed_migration
    if @failure == 0
      redirect_to admin_budget_budget_manages_path(@budget), notice: I18n.t('flash.actions.create.budget_investment')
    else
      redirect_to admin_budget_budget_manages_path(@budget), flash: { error: I18n.t('flash.actions.create.error_investment', count: @failure.to_s) }
    end
  end

  private
    def load_budget
      @budget = Budget.find(params[:budget_id])
    end

    def load_proposals
      @proposals = Proposal.successful.order(cached_votes_up: :desc).where(status: false).where.not(level: nil).page(params[:page]).per(5)
    end

    def load_heading
      if params["heading_id"].present?
        @heading = @budget.headings.find(params["heading_id"])
      end
    end

    def seed_migration
      @count = 0
      @seeds = @proposals.where(id: params["proposal_ids"])
      @seeds.each do |seed|
        @investment = seed_transaction seed
        if @investment.save
          seed.status = true
          seed.save
          save_image seed.id, @investment.id
          save_document seed.id, @investment.id
          save_map seed.id, @investment.id
          save_tag seed.id, @investment.id
          save_comments seed.id, @investment.id
          Mailer.budget_investment_created(@investment).deliver_later
        else
          @count += 1
        end
      end
      @count
    end

    def seed_transaction(seed)
      Budget::Investment.new(
        :terms_of_service => "1",
        :author_id => seed.author_id,
        :administrator_id => current_user.id,
        :title => seed.title,
        :description => seed.description,
        :external_url => seed.external_url,
        :price => seed.price,
        :price_first_year => seed.price_first_year,
        :duration => seed.duration,
        :cached_votes_up => seed.cached_votes_up,
        :comments_count => seed.comments_count,
        :confidence_score => seed.confidence_score,
        :created_at => seed.created_at,
        :heading_id => @heading.id,
        :responsible_name => seed.responsible_name,
        :budget_id => @budget.id,
        :group_id => @heading.group_id,
        :geozone_id => seed.geozone_id,
        :location => seed.geozone.present? ? seed.geozone.name : "",
        :community_id => seed.community_id,
        :skip_map => "1",
        :proposal_id => seed.id
      )
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

end
