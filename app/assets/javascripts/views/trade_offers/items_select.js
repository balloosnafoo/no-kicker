NoKicker.Views.TradeOfferItemsSelect = Backbone.CompositeView.extend({
  template: JST['trade_offers/items_select'],

  className: "container",

  events: {
    "submit .trade-item-form": "makeTradeOffer"
  },

  initialize: function (options) {
    this.partnerTeam = options.partner;
    this.league = options.league;
    this.user_team = this.league.user_team();

    this.listenTo(this.partner_team, "sync", this.render);
    this.listenTo(this.league, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template();

    this.$el.html(renderedContent);
    this.renderPlayers();
    return this;
  },

  // ownerTeam not yet in use, was an attempt to get owners username
  addPlayer: function (ownerTeam, rosterSlot) {
    // debugger
    var playerView = new NoKicker.Views.RosterSlotTradeIndexItem({
      model: rosterSlot,
      team: ownerTeam,
      user_team: this.user_team
    });

    this.addSubview('.trade-item-table', playerView);
  },

  renderPlayers: function () {
    this.partnerTeam.roster_slots().each(this.addPlayer.bind(this, this.partnerTeam));
    this.$('.trade-item-table').append(
      "<tr><th class='vertical-spacer table-heading' colspan='12'><h3>Offered Players</h3></th></tr>"
    )
    this.user_team.roster_slots().each(this.addPlayer.bind(this, this.user_team));
  },

  makeTradeOffer: function (event) {
    event.preventDefault();
    debugger;
  }
});
