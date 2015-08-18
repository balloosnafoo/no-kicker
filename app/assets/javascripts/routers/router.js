NoKicker.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.leagues = options.leagues;
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
    "leagues/:league_id/players": "playerIndex",
    "leagues/:league_id/add/:player_id": "addPlayer",
    "leagues/:league_id/messages": "messageIndex"
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

  playerIndex: function (league_id) {
    this.players.fetch({ data: { league_id: league_id } });
    var indexView = new NoKicker.Views.PlayerIndex({
      collection: this.players,
      league: this.leagues.getOrFetch(league_id)
    });

    this._swapView(indexView);
  },

  addPlayer: function (league_id, player_id) {
    // debugger;
    var league = this.leagues.getOrFetch(league_id, { user_team: true });
    var player = this.players.getOrFetch(player_id);
    var addView = new NoKicker.Views.TeamAddDrop({
      league: league,
      toAddPlayer: player
    });

    this._swapView(addView);
  },

  messageIndex: function (league_id) {
    var league = this.leagues.getOrFetch(league_id);
    var messages = new NoKicker.Collections.Messages()
    messages.fetch({data: {league_id: league_id}});
    var indexView = new NoKicker.Views.MessageIndex({
      collection: messages,
      league: league
    });

    this._swapView(indexView);
  },

  _swapView: function (view) {
    this._view && this._view.remove();
    this._view = view;
    this.$rootEl.html(view.render().$el);
  }
});
