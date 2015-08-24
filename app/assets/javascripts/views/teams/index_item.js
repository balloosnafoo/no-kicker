NoKicker.Views.TeamIndexItem = Backbone.View.extend({
  template: JST['teams/index_item'],

  tagName: 'tr',

  initialize: function (options) {
    this.league = options.league;
  },

  render: function () {
    var renderedContent = this.template({
      team: this.model,
      league: this.league
    });

    this.$el.html(renderedContent);
    if (this.model.escape("manager_username") === NoKicker.CURRENT_USER.username) {
      this.$el.addClass("warning");
    }
    return this;
  }
});
