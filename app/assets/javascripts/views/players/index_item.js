NoKicker.Views.PlayerIndexItem = Backbone.View.extend({
  template: JST['players/index_item'],

  tagName: 'tr',

  className: "player-listing",

  events: {
    "click .trade-button": "addPlayer"
  },

  initialize: function (options) {
    this.league = options.league;
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      player: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  addPlayer: function (event) {
    debugger;
    event.preventDefault();
    var newContract = new NoKicker.Models.PlayerContract();
    newContract.set({
      player_id: this.model.id,
      league_id: this.league.id
    });

    newContract.save({}, {
      success: function () {
        debugger;
      },
      error: function () {
        debugger;
      }
    });
  }
});
