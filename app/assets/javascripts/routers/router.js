NoKicker.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.collection = new NoKicker.Collections.Leagues();
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "leagueIndex",
    "leagues/new": "leagueNew",
    "leagues/:id": "leagueShow",
    "leagues/:league_id/teams/new": "teamNew"
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
    var team = new NoKicker.Models.Team();
    var formView = new NoKicker.Views.TeamForm({
      model: team
    });

    this._swapView(formView);
  },

  _swapView: function (view) {
    this._view && this._view.remove();
    this._view = view;
    this.$rootEl.html(view.render().$el);
  }
});
