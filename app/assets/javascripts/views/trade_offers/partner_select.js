NoKicker.Views.TradeOfferPartnerSelect = Backbone.CompositeView.extend({
  template: JST['trade_offers/partner_select'],

  className: "container",

  events: {
    "submit .partner-select-form": "choosePlayers"
  },

  initialize: function (options) {
    this.league = options.league;
    this.teams = this.league.teams();

    this.listenTo(this.league, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      teams: this.teams
    });

    this.$el.html(renderedContent);
    return this;
  },

  choosePlayers: function (event) {
    event.preventDefault();
    var partnerId = $(event.currentTarget).serializeJSON().tradee_id;
    Backbone.history.navigate(
      "leagues/" + this.league.id + "/trades/" + partnerId,
      { trigger: true }
    )
  }
})
