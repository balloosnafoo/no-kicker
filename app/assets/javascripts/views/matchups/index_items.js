NoKicker.Views.MatchupIndexItem = Backbone.View.extend({
  template: JST['matchups/index_item'],

  tagName: "table",

  className: "table table-condensed table-striped table-bordered",

  initialize: function (options) {
    this.league = options.league;

    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      matchup: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
