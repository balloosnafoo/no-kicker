NoKicker.Views.LeagueNav = Backbone.View.extend({
  template: JST ['nav/league_nav'],

  tagName: "ul",

  className: "nav navbar-nav",

  render: function () {
    var renderedContent = this.template({
      league: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
