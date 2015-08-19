NoKicker.Views.TradeItemIndexItem = Backbone.View.extend({
  template: JST['trade_items/index_item'],

  render: function () {
    var renderedContent = this.template({
      tradeItem: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
