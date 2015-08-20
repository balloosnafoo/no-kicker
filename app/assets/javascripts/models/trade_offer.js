NoKicker.Models.TradeOffer = Backbone.Model.extend({
  urlRoot: "/api/trade_offers",

  givenItems: function () {
    if (!this._givenItems) {
      this._givenItems = new NoKicker.Collections.TradeItems(
        [], { tradeOffer: this }
      );
    }

    return this._givenItems;
  },

  receivedItems: function () {
    if (!this._receivedItems) {
      this._receivedItems = new NoKicker.Collections.TradeItems(
        [], { tradeOffer: this }
      );
    }

    return this._receivedItems;
  },

  trader: function () {
    if (!this._trader) {
      this._trader = new NoKicker.Models.Team();
    }

    return this._trader;
  },

  tradee: function () {
    if (!this._tradee) {
      this._tradee = new NoKicker.Models.Team();
    }

    return this._tradee;
  },

  parse: function (response) {
    if (response.received_items) {
      this.receivedItems().set(response.received_items, { parse: true });
      delete response.receivedItems;
    }

    if (response.given_items) {
      this.givenItems().set(response.given_items, { parse: true });
      delete response.givenItems;
    }

    if (response.trader) {
      this.trader().set(response.trader);
      delete response.trader;
    }

    if (response.tradee) {
      this.tradee().set(response.tradee);
      delete response.tradee;
    }

    return response;
  },
});
