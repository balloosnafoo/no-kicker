NoKicker.Collections.TradeItems = Backbone.Collection.extend({
  url: "/api/trade_items",

  model: NoKicker.Models.TradeItem
});
