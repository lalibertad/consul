class Admin::BudgetManagesController < Admin::BaseController

  before_action :load_budget
  before_action :load_heading
  before_action :load_proposals

  def create
    failure = seed_migration
    if failure.count == 0
      redirect_to admin_budget_budget_manages_path(@budget), notice: I18n.t('flash.actions.create.budget_investment')
    else
      redirect_to admin_budget_budget_manages_path(@budget), flash: { error: I18n.t('flash.actions.create.error_investment', error: failure.to_s) }
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
      errors = []
      @seeds = Proposal.where(id: params["proposal_ids"])
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
          error = [seed.code, @investment.errors.messages]
          errors.push(error)
        end
      end
      errors
    end

    def seed_transaction(seed)
      Budget::Investment.new(
        :terms_of_service => "1",
        :author_id => seed.author_id,
        :administrator_id => current_user.id,
        :title => seed.title,
        :description => (add_details(seed).to_s + (seed.description.present? ? seed.description.to_s : "")),
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

    def add_details(detail)
      txt =  detail.snip.present? ? "<p>INVIERTE:PE: <strong>" + detail.snip + "</strong></p>" : ""
      txt += "<p><strong>Nivel de estudio del proyecto:</strong> " + detail.level + "</p>"
      txt += "<p><strong>Brecha a la que contribuye:</strong> " + detail.gap_contributes + "</p>" if detail.gap_contributes.present?
      txt += "<p><strong>Objetivo estratégico del PDRG-LL 2016-2021 al que contribuye:</strong> " + detail.strategic_objective + "</p>" if detail.strategic_objective.present?
      txt += "<p><strong>Objetivos específicos:</strong> " + detail.specific_objective + "</p>" if detail.specific_objective.present?
      txt += "<p><strong>Problema específico que contribuye a solucionar:</strong> " + detail.problem_solve + "</p>" if detail.problem_solve.present?
      txt += "<p><strong>Potencialidad que aprovecha para desarrollar:</strong> " + detail.potentiality_solve + "</p>" if detail.potentiality_solve.present?
      txt += "<p><strong>Unidad ejecutora:</strong> " + detail.executor + "</p>" if detail.executor.present?
      txt += "<p><strong>Entidad responsable del mantenimiento:</strong> " + detail.responsable + "</p>" if detail.responsable.present?
      return txt
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
