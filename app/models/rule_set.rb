class RuleSet < ActiveRecord::Base
  belongs_to(
    :league,
    class_name: "League",
    foreign_key: :league_id,
    primary_key: :id
  )
end
