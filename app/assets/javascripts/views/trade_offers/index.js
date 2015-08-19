NoKicker.Views.TradeOfferIndex = Backbone.CompositeView.extend({
  template: JST['trade_offers/index'],

  className: "container",

  initialize: function (options) {
    debugger;
    this.league = options.league
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addItem);
  },

  render: function () {
    var renderedContent = this.template({
      tradeOffers: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  },

  addTrade: function (trade) {
    var tradeView = new NoKicker.Views.TradeOfferIndexItem({
      model: trade,
      collection: this.collection
    });

    this.addSubview('.trade-index', tradeView);
  },

  renderTrades: function () {
    this.collection.models.each(this.addTrade.bind(this));
  }
})
