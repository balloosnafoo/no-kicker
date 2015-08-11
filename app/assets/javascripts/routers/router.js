NoKicker.Routers.Router = Backbone.Router.extend({
  initialize: function () {
    this.collection = new NoKicker.Collections.Leagues();
  }

  routes: {
    "leagues/new" : "newLeague",
  },

  newLeague: function () {
    var league = new NoKicker.Models.League();
    var newView = new NoKicker.Views.LeagueNew({
      model: league
    });

    this._swapView(newView);
  },

  _swapView: function (view) {
    this._view && this._view.remove();
    this._view = view;
    this.$rootEl.html(view.render().$el);
  }
});
