class PerformLaterActorJob < ActiveJob::Base
  def perform(action, curation_concern, ability_user, attributes_for_actor)
    # Rebuild the actor environment
    # JA - remove the in_perform_later_actor_job attribute
    attributes_for_actor.delete 'in_perform_later_actor_job'
    env = Hyrax::Actors::Environment.new(curation_concern.constantize.new, ::Ability.new(ability_user), attributes_for_actor)
    Hyrax::CurationConcern.actor.send(action, env)
  end
end
