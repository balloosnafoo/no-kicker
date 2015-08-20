NoKicker.Views.TradeOfferIndex = Backbone.CompositeView.extend({
  template: JST['trade_offers/index'],

  className: "container",

  events: {
    "click .new-trade-button": "newTrade"
  },

  initialize: function (options) {
    this.league = options.league;
    
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addItem);
  },

  render: function () {
    var renderedContent = this.template({
      tradeOffers: this.collection
    });

    this.$el.html(renderedContent);
    this.renderTrades();
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
    this.collection.each(this.addTrade.bind(this));
  },

  newTrade: function () {
    event.preventDefault();
    Backbone.history.navigate(
      "leagues/" + this.league.id + "/trades/new",
      { trigger: true }
    );
  }
})
