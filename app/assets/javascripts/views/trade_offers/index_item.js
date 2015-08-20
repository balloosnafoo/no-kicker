NoKicker.Views.TradeOfferIndexItem = Backbone.CompositeView.extend({
  template: JST['trade_offers/index_item'],

  tagName: "li",

  className: "trades-index-item",

  events: {
    "click .accept-button": "acceptTrade",
    "click .reject-button": "rejectTrade"
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
      success: function () {debugger;}.bind(this),
      error: function () {debugger;}.bind(this)
    });
  },

  cancelTrade: function (event) {
    event.preventDefault();
    debugger;
  },

  rejectTrade: function (event) {
    debugger;
    event.preventDefault();
    this.model.destroy();
    this.model.clear();
    Backbone.history.navigate(
      "leagues/" + this.league.id + "/trades",
      { trigger: true }
    );
  }
});
