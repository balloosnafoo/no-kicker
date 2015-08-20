NoKicker.Views.TradeOfferIndexItem = Backbone.CompositeView.extend({
  template: JST['trade_offers/index_item'],

  tagName: "li",

  className: "trades-index-item",

  initialize: function () {
    this.receivedItems = this.model.receivedItems();
    this.givenItems = this.model.givenItems();
    this.trader = this.model.trader();
    this.tradee = this.model.tradee();

    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      tradeOffer: this.model,
      receivedItems: this.receivedItems,
      givenItems: this.givenItems,
      trader: this.trader,
      tradee: this.tradee
    });

    this.$el.html(renderedContent);
    return this;
  }
});
