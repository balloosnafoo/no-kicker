NoKicker.Views.TradeOfferForm = Backbone.CompositeView.extend({
  template: JST['trade_offers/form'],

  render: function () {
    var renderedContent = this.template({});

    this.$el.html(renderedContent);
    return this;
  }
});
