NoKicker.Views.LeagueNav = Backbone.View.extend({
  template: JST ['nav/league_nav'],

  tagName: "ul",

  className: "nav navbar-nav",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      league: this.model,
      leagues: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  }
});
