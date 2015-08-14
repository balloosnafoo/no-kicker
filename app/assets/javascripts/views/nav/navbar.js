NoKicker.Views.Navbar = Backbone.View.extend({
  template: JST["nav/nav"],

  initialize: function (options) {
    this.router = options.router;
    this.collection = options.leagues;
    this.$subEl = $('page-specific-links');

    this.listenTo(this.router, "route", this.handleRoute);
  },

  LEAGUE_ROUTES: {
    "leagueShow": true,
    "teamNew": true,
    "teamShow": true,
    "playerIndex": true,
    "addPlayer": true
  },

  handleRoute: function (routeName, params) {
    this.$el.find(".active").removeClass("active");
    this.$el.find("." + routeName).addClass("active");

    // This seems really dumb and convoluted... halp.
    if (this.LEAGUE_ROUTES[routeName]) {
      var league = this.collection.getOrFetch(params[0]);
      this.subnav = new NoKicker.Views.LeagueNav({
        collection: this.collection,
        model: league,
        $el: this.$('.page-specific-links')
      });
      this.$subEl.html(this.subnav.render().$el);
    } else {
      this.subnav && this.subnav.remove();
    }
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  }
});



// On logout set window.location = "/"
