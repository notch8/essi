class M3Context < ApplicationRecord
  belongs_to :m3_profile
  has_many :dynamic_schemas
  serialize :admin_set_ids, Array

  # @api public
  # @param admin_set_id [#to_s] the admin set to which we will scope our query.
  # @return [M3Context] that is active for the given administrative set`
  # @note using select here may not be performant if there are many contexts
  #   because the field is an array, using .where(admin_set_ids: ["#{query_term}"])
  #   will only work on exact matches
  def self.find_metadata_context_for(admin_set_id:)
    M3Context.select { |c| c.admin_set_ids.include?(admin_set_id) }.first
  end

  # @api public
  # @return [Array] all M3Contexts
  def self.available_contexts
    M3Context.all
  end
end
