json.array! @trade_offers do |trade_offer|
  json.extract! trade_offer, :trader_id, :tradee_id, :league_id
  json.array! @trade_offer.trade_items do |trade_item|
    json.extract! trade_item, :player_id, :owner_id, :trade_offer_id
  end
end
