window.NoKicker = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new NoKicker.Routers.Router({
      $rootEl: $('#content')
    });

    var nav = new NoKicker.Views.Navbar({
      router: router
      // There was a passed in collection in the demo
    });

    $("#navbar").html(nav.render().$el);

    Backbone.history.start();
  }
};

// $(document).ready(function(){
//   NoKicker.initialize();
// });
