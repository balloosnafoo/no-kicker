NoKicker.Views.MatchupIndexItem = Backbone.View.extend({
  template: JST['matchups/index_item'],

  render: function () {
    var renderedContent = this.template({
      matchup: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
