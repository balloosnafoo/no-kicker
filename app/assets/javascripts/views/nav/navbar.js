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
    "messageShow": true
  },

  handleRoute: function (routeName, params) {
    this.$el.find(".active").removeClass("active");
    this.$el.find("." + routeName).addClass("active");

    if (this.LEAGUE_ROUTES[routeName]) {
      var league = this.collection.getOrFetch(params[0], {user_team: true});
      this.subnav = new NoKicker.Views.LeagueNav({
        collection: this.collection,
        model: league
      });
      this.$(".page-specific-links").html(this.subnav.render().$el);
    } else {
      this.subnav && this.subnav.remove();
    }
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  logout: function () {
    $.ajax({
      url: "/session/",
      type: "DELETE",
      success: function () {
        window.location = "/";
      }
    });
  }

});



// On logout set window.location = "/"
