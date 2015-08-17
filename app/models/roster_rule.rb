class RosterRule < ActiveRecord::Base
  validates :num_qbs, :num_rbs, :num_wrs, :num_tes, :num_flex,
            :num_dst, :num_k, :num_bench, presence: true

  belongs_to :league

  POSITIONS = {
    num_qbs: :qb,
    num_rbs: :rb,
    num_wrs: :wr,
    num_tes: :te,
    num_flex: :flex,
    num_dst: :dst,
    num_k: :k,
    num_bench: :bench
  }

  def total_slots
    num_qbs + num_rbs + num_wrs + num_tes + num_flex + num_dst +
      num_k + num_bench
  end

  def generate_roster_slots(team)
    RosterRule::POSITIONS.each do |method, pos|
      send(method).times do |i|
        RosterSlot.create(team_id: team.id, position: pos, order: i)
      end
    end
  end
end
