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
    var formData = $(event.currentTarget).serializeJSON().trade;
    var toGiveIds = formData.toGive;
    var toReceiveIds = formData.toReceive;

    var tradeOffer = new NoKicker.Models.TradeOffer({
      league_id: this.league.id,
      tradee_id: this.partnerTeam.id
    });

    tradeOffer.save({}, {
      success: function () {
        this.createItems(toGiveIds, this.user_team, tradeOffer.id);
        this.createItems(toReceiveIds, this.partnerTeam, tradeOffer.id);
        Backbone.history.navigate(
          "leagues/" + this.league.id + "/trades",
          { trigger: true }
        )
      }.bind(this),
      error: function () { debugger }.bind(this)
    });
  },

  createItems: function (ids, ownerTeam, tradeId) {
    for (var i = 0; i < ids.length; i++) {
      var tradeItem = new NoKicker.Models.TradeItem({
        player_id: ids[i],
        owner_id: ownerTeam.id,
        trade_offer_id: tradeId
      });
      tradeItem.save({}, {
        error: function () { debugger }.bind(this)
      });
    }
  }

});
