NoKicker.Views.LeagueShow = Backbone.CompositeView.extend({
  template: JST['leagues/show'],

  className: "container-fluid",

  events: {
    "click .join-league": "newTeam"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.teams(), "add", this.addTeam);
  },

  addTeam: function (team) {
    var teamView = new NoKicker.Views.TeamIndexItem({
      model: team,
      league: this.model
    });

    this.addSubview('.teams-table', teamView);
  },

  render: function () {
    var renderedContent = this.template({
      league: this.model,
      teams: this.model.teams()
    });

    this.$el.html(renderedContent);
    this.renderTeams();
    this.renderBlankRows();
    return this;
  },

  renderTeams: function () {
    this.model.teams().sort();
    this.model.teams().each(this.addTeam.bind(this));
  },

  renderBlankRows: function () {
    var blanks = this.model.escape("num_teams") - this.model.teams().length;
    var nullTeam = NoKicker.Models.nullTeam;
    for (var i = 0; i < blanks; i++) {
      this.addTeam(nullTeam);
    }
  },

  newTeam: function (event) {
    event.preventDefault();
    Backbone.history.navigate(
      "leagues/" + this.model.id + "/teams/new",
      { trigger: true }
    );
  }
});
