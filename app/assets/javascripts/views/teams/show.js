NoKicker.Views.TeamShow = Backbone.CompositeView.extend({
  template: JST['teams/show'],

  className: "container team-show",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.players(), "add", this.addTeam);
  },

  addPlayer: function (player) {
    var playersView = new NoKicker.Views.PlayerTeamIndexItem({
      model: player,
      league: this.model
    });

    this.addSubview('.roster-table', playersView);
  },

  render: function () {
    var renderedContent = this.template({
      team: this.model
    });

    this.$el.html(renderedContent);
    this.renderPlayers();
    return this;
  },

  renderPlayers: function () {
    this.model.players().each(this.addPlayer.bind(this));
  }
});
