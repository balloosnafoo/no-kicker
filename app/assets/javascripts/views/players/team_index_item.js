NoKicker.Views.PlayerTeamIndexItem = Backbone.View.extend({
  template: JST['players/team_index_item'],

  tagName: "tr",

  render: function () {
    var renderedContent = this.template({
      player: this.model,
      stats: this.model.stats()
    });

    this.$el.html(renderedContent);
    return this;
  }
});
