NoKicker.Views.LeagueNav = Backbone.View.extend({
  template: JST ['nav/league_nav'],

  initialize: function (options) {
    this.$el = options.$el;
  },

  render: function () {
    var renderedContent = this.template({
      league: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
