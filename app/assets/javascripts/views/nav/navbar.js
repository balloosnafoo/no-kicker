NoKicker.Views.Navbar = Backbone.View.extend({
  template: JST["nav/nav"],

  events: {
    "click .logout": "logout"
  },

  initialize: function (options) {
    this.router = options.router;
    this.collection = options.leagues;

    this.listenTo(this.router, "route", this.handleRoute);
  },

  LEAGUE_ROUTES: {
    "leagueShow": true,
    "teamNew": true,
    "teamShow": true,
    "playerIndex": true,
    "addPlayer": true,
    "messageIndex": true,
    "messageNew": true,
    "messageShow": true,
    "tradeIndex": true,
    "tradeNew": true,
    "tradeCustomize": true,
    "matchupIndex": true,
    "matchupsByWeek": true
  },

  handleRoute: function (routeName, params) {
    this.$el.find(".active").removeClass("active");
    this.$el.find("." + routeName).addClass("active");
    var navbar;

    if (this.LEAGUE_ROUTES[routeName]) {

      // Change the color of the navbar to black to indicate that user
      // is within the scope of a particular league.
      navbar = this.$('nav.navbar');
      if (navbar.length) {
        navbar.removeClass("navbar-default");
        navbar.addClass("navbar-inverse");
      }

      var league = this.collection.getOrFetch(params[0], {user_team: true});
      this.subnav = new NoKicker.Views.LeagueNav({
        collection: this.collection,
        model: league
      });
      this.$(".page-specific-links").html(this.subnav.render().$el);
    } else {
      if(this.subnav) this.subnav.remove();

      // Change the color of the navbar back to white to indicate that
      // user is outside of league scope.
      navbar = this.$('nav.navbar');
      if (navbar.length) {
        navbar.removeClass("navbar-inverse");
        navbar.addClass("navbar-default");
      }
    }
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  logout: function (event) {
    event.preventDefault();
    $.ajax({
      url: "/session/",
      type: "DELETE",
      success: function () {
        window.location = "/";
      }
    });
  }

});
