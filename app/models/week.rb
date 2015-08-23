class Week < ActiveRecord::Base
  def self.matchups
    Matchup.where(week: Week.first.current_week)
  end

  def self.current_week
    Week.first.current_week
  end

  def self.to_next_week!
    Matchup.where(week: Week.current_week + 1).find_each do |matchup|
      league = matchup.league
      puts "#{matchup.team_1_id} vs #{matchup.team_2_id}"
      team_1_total = 0
      matchup.team_1.roster_slots.each do |slot|
        if slot.position != "bench" && slot.player && slot.player.weekly_stats
          team_1_total += league.score_player(slot.player)
        end
      end

      team_2_total = 0
      matchup.team_2.roster_slots.each do |slot|
        if slot.position != "bench" && slot.player && slot.player.weekly_stats
          team_2_total += league.score_player(slot.player)
        end
      end

      matchup.team_1_score = team_1_total
      matchup.team_2_score = team_2_total
      matchup.save
    end
    w = Week.first
    w.current_week = w.current_week + 1
    w.save
  end
end
