NoKicker.Views.TradeOfferIndex = Backbone.CompositeView.extend({
  template: JST['trade_offers/index'],

  className: "container",

  render: function () {
    var renderedContent = this.template({
      tradeOffers: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  }
})
