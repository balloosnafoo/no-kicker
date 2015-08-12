NoKicker.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.collection = new NoKicker.Collections.Leagues();
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "leagueIndex",
    "leagues/new": "leagueNew",
    "leagues/:id": "leagueShow",
    "leagues/:league_id/teams/new": "teamNew",
    "leagues/:league_id/teams/:team_id": "teamShow"
  },

  leagueIndex: function () {
    this.collection.fetch({ data: { user_leagues: true } });
    var indexView = new NoKicker.Views.LeagueIndex({
      collection: this.collection
    });

    this._swapView(indexView);
  },

  leagueNew: function () {
    var league = new NoKicker.Models.League();
    var newView = new NoKicker.Views.LeagueNew({
      model: league,
      collection: this.collection
    });

    this._swapView(newView);
  },

  leagueShow: function (id) {
    var league = this.collection.getOrFetch(id);
    var showView = new NoKicker.Views.LeagueShow({
      model: league
    });

    this._swapView(showView);
  },

  teamNew: function (league_id) {
    var team = new NoKicker.Models.Team({league_id: league_id});
    // var teams = this.collection.getOrFetch(league_id).teams();
    var formView = new NoKicker.Views.TeamForm({
      model: team
      // , collection: teams
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

  _swapView: function (view) {
    this._view && this._view.remove();
    this._view = view;
    this.$rootEl.html(view.render().$el);
  }
});
