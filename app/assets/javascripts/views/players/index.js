NoKicker.Views.PlayerIndex = Backbone.CompositeView.extend({
  template: JST['players/index'],

  className: "container players-index",

  initialize: function (options) {
    this.league = options.league;
    this.listenTo(this.collection, "add", this.addPlayer);
    this.listenTo(this.collection, "sync", this.render)
  },

  addPlayer: function (player) {
    var playerView = new NoKicker.Views.PlayerIndexItem({
      model: player,
      league: this.league
    });

    this.addSubview('.players-table', playerView);
  },

  render: function () {
    this.$el.html(this.template());
    this.renderPlayers();
    return this;
  },

  renderPlayers: function () {
    this.collection.each(this.addPlayer.bind(this));
  }
});
