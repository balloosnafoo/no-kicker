NoKicker.Views.TradeOfferIndexItem = Backbone.CompositeView.extend({
  template: JST['trade_offers/index_item'],

  tagName: "div",

  className: "trades-index-item list-group-item clearfix",

  events: {
    "click .accept-button": "acceptTrade",
    "click .reject-button": "rejectTrade",
    "click .cancel-button": "cancelTrade"
  },

  initialize: function (options) {
    this.receivedItems = this.model.receivedItems();
    this.givenItems    = this.model.givenItems();
    this.trader        = this.model.trader();
    this.tradee        = this.model.tradee();
    this.league        = options.league;

    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      tradeOffer:    this.model,
      receivedItems: this.receivedItems,
      givenItems:    this.givenItems,
      trader:        this.trader,
      tradee:        this.tradee
    });

    this.$el.html(renderedContent);
    return this;
  },

  acceptTrade: function () {
    this.model.set({ pending: false });
    this.model.save({}, {
      success: function () {
        Backbone.history.navigate(
          "leagues/" + this.league.id + "/teams/" + this.tradee.id,
          { trigger: true }
        )
      }.bind(this)
    });
  },

  cancelTrade: function (event) {
    event.preventDefault();
    this.model.destroy();
    this.model.clear();
    Backbone.history.navigate(
      "leagues/" + this.league.id + "/trades",
      { trigger: true }
    );
  },

  rejectTrade: function (event) {
    event.preventDefault();
    this.model.destroy();
    this.model.clear();
    Backbone.history.navigate(
      "leagues/" + this.league.id + "/trades",
      { trigger: true }
    );
  }
});
