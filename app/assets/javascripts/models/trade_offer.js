NoKicker.Models.TradeOffer = Backbone.Model.extend({
  urlRoot: "/api/trade_offers",

  tradeItems: function () {
    if (!this._tradeItem) {
      this._tradeItem = new NoKicker.Collections.TradeItems(
        [], { tradeOffer: this }
      );
    }

    return this._tradeItem;
  },

  trader: function () {
    if (!this._trader) {
      this._trade = new NoKicker.Models.Team();
    }

    return this._trader;
  },

  parse: function (response) {
    if (response.trade_items) {
      this.tradeItems().set(response.trade_items, { parse: true });
      delete response.tradeItems;
    }

    if (response.trader) {
      this.trader().set(response.trader);
      delete response.trader;
    }

    return response;
  }
})
