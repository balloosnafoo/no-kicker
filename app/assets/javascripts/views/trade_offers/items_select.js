NoKicker.Views.TradeOfferItemsSelect = Backbone.CompositeView.extend({
  template: JST['trade_offers/items_select'],

  className: "container",

  initialize: function (options) {
    this.partner_team = options.partner;
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

  addPlayer: function (rosterSlot) {
    var playerView = new NoKicker.Views.RosterSlotTradeIndexItem({
      model: rosterSlot,
      team: this.model
    });

    this.addSubview('.trade-item-table', playerView);
  },

  renderPlayers: function () {
    debugger
    this.partner_team.roster_slots().each(this.addPlayer.bind(this));
    this.$('.trade-item-table').append(
      "<tr><th class='vertical-spacer table-heading' colspan='12'><h3>Offered Players</h3></th></tr>"
    )
    this.user_team.roster_slots().each(this.addPlayer.bind(this));
  },
});
