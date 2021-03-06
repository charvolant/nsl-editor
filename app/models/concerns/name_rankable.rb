# frozen_string_literal: true

# Name scopes
module NameRankable
  extend ActiveSupport::Concern
  included do
    belongs_to :name_rank
  end

  def parent_rank_above?
    parent.present? &&
      parent.name_rank.present? &&
      name_rank.present? &&
      parent.name_rank.above?(name_rank)
  end

  def both_unranked?
    name_rank_id == parent.name_rank_id && name_rank.unranked?
  end

  # TODO: Boolean function shouldn't add error.
  def parent_rank_high_enough?
    if requires_parent? && requires_higher_ranked_parent?
      unless parent.blank? || parent_rank_above? || both_unranked?
        errors.add(:parent_id, "rank (#{parent.try('name_rank').try('name')})
                   must be higher than name rank (#{name_rank.try('name')})")
      end
    end
  end

  def rank_takes_parent?
    parent_name_rank.real_parent?
  end

  def parent_name_rank
    name_rank.parent
  end
end
