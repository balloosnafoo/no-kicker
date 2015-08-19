NoKicker.Views.TradeOfferIndexItem = Backbone.CompositeView.extend({
  template: JST['trade_offers/index_item'],

  tagName: "li",

  className: "trades-index-item",

  render: function () {
    var renderedContent = this.template({
      tradeOffer: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
