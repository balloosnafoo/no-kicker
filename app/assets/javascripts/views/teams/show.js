NoKicker.Views.TeamShow = Backbone.CompositeView.extend({
  template: JST['teams/show'],

  className: "container team-show",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  addPlayer: function (team) {
    var playersView = new NoKicker.Views.PlayerTeamIndexItem({
      model: players,
      league: this.model
    });

    this.addSubview('.player-table', playersView);
  },

  render: function () {
    var renderedContent = this.template({
      team: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  renderPlayers: function () {
    this.model.players().each(this.addPlayer.bind(this));
  }
});
