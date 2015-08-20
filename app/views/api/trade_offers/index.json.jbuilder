json.array! @trade_offers do |trade_offer|
  json.extract! trade_offer, :id, :trader_id, :tradee_id, :league_id, :pending

  json.made_offer @team == trade_offer.trader

  json.trader do
    json.extract! trade_offer.trader, :id, :name
  end

  json.tradee do
    json.extract! trade_offer.tradee, :id, :name
  end

  json.received_items do
    json.array! trade_offer.trade_items do |trade_item|
      if trade_item.owner_id != current_user.id
        json.extract! trade_item.player, :id, :fname, :lname, :position, :team_name
      end
    end
  end

  json.given_items do
    json.array! trade_offer.trade_items do |trade_item|
      if trade_item.owner_id == current_user.id
        json.extract! trade_item.player, :id, :fname, :lname, :position, :team_name
      end
    end
  end
end
