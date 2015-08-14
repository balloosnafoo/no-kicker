NoKicker.Views.PlayerIndexItem = Backbone.View.extend({
  template: JST['players/index_item'],

  tagName: 'tr',

  className: "player-listing",

  events: {
    "click .add-button": "addPlayer",
    "click .trade-button": "tradePlayer",
    "click .drop-button": "dropPlayer"
  },

  initialize: function (options) {
    this.league = options.league;
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.contract(), "change", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      player: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  addPlayer: function (event) {
    event.preventDefault();
    this.model.contract().set({
      player_id: this.model.id,
      league_id: this.league.id,
      user_player: true
    });
    this.model.contract().save({}, {
      error: function (contract, response) {
        Backbone.history.navigate(
          "leagues/" + this.league.id + "/add/" + contract.escape("player_id"),
          { trigger: true }
        );
      }.bind(this)
    });
  },

  dropPlayer: function (event) {
    event.preventDefault();
    this.model.contract().destroy();
    this.model.contract().clear();
  }
});
