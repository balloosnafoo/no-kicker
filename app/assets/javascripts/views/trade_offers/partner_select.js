NoKicker.Views.TradeOfferPartnerSelect = Backbone.CompositeView.extend({
  template: JST['trade_offers/partner_select'],

  initialize: function (options) {
    debugger;
    this.league = options.league;
    this.teams = this.league.teams();
  },

  render: function () {
    var renderedContent = this.template({
      teams: this.teams
    });

    this.$el.html(renderedContent);
    return this;
  }
})
