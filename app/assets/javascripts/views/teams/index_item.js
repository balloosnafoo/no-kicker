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
    return this;
  }
});
