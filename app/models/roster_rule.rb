class RosterRule < ActiveRecord::Base
  validates :num_qbs, :num_rbs, :num_wrs, :num_tes, :num_flex,
            :num_dst, :num_k, :num_bench, presence: true

  belongs_to :league

  def total_slots
    num_qbs + num_rbs + num_wrs + num_tes + num_flex + num_dst +
      num_k + num_bench
  end
end
