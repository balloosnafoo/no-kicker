window.NoKicker = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var leagues = new NoKicker.Collections.Leagues();
    var router = new NoKicker.Routers.Router({
      $rootEl: $('#content'),
      leagues: leagues
    });

    var nav = new NoKicker.Views.Navbar({
      router: router,
      leagues: leagues
      // There was a passed in collection in the demo
    });

    $("#navbar").html(nav.render().$el);

    Backbone.history.start();
  }
};

// $(document).ready(function(){
//   NoKicker.initialize();
// });
