NoKicker.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.leagues = new NoKicker.Collections.Leagues();
    this.players = new NoKicker.Collections.Players();
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "userLeagueIndex",
    "leagues/all": "leagueIndex",
    "leagues/new": "leagueNew",
    "leagues/:id": "leagueShow",
    "leagues/:league_id/teams/new": "teamNew",
    "leagues/:league_id/teams/:team_id": "teamShow",
    "players": "playerIndex"
  },

  userLeagueIndex: function () {
    this.leagues.fetch({ data: { user_leagues: true } });
    var indexView = new NoKicker.Views.LeagueIndex({
      collection: this.leagues
    });

    this._swapView(indexView);
  },

  leagueIndex: function () {
    this.leagues.fetch();
    var indexView = new NoKicker.Views.LeagueAllIndex({
      collection: this.leagues
    });

    this._swapView(indexView);
  },

  leagueNew: function () {
    var league = new NoKicker.Models.League();
    var newView = new NoKicker.Views.LeagueNew({
      model: league,
      collection: this.leagues
    });

    this._swapView(newView);
  },

  leagueShow: function (id) {
    var league = this.leagues.getOrFetch(id);
    var showView = new NoKicker.Views.LeagueShow({
      model: league
    });

    this._swapView(showView);
  },

  teamNew: function (league_id) {
    var team = new NoKicker.Models.Team({league_id: league_id});
    var formView = new NoKicker.Views.TeamForm({
      model: team
    });

    this._swapView(formView);
  },

  teamShow: function (league_id, team_id) {
    var teams = new NoKicker.Collections.Teams();
    var team = teams.getOrFetch(team_id);
    var showView = new NoKicker.Views.TeamShow({
      model: team
    });

    this._swapView(showView);
  },

  playerIndex: function () {
    this.players.fetch();
    var indexView = new NoKicker.Views.PlayerIndex({
      collection: this.players
    });

    this._swapView(indexView);
  },

  _swapView: function (view) {
    this._view && this._view.remove();
    this._view = view;
    this.$rootEl.html(view.render().$el);
  }
});
