NoKicker.Views.TradeOfferItemsSelect = Backbone.View.extend({
  template: JST['trade_offers/items_select'],

  className: "container",

  initialize: function (options) {
    this.partner = options.partner;
    this.league = options.league;
  },

  render: function () {
    debugger;
    var renderedContent = this.template({

    });

    this.$el.html(renderedContent);
    return this;
  }
});
