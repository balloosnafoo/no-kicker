NoKicker.Views.LeagueAllIndexItem = Backbone.View.extend({
  template: JST['leagues/all_index_item'],

  tagName: "tr",

  className: "league-all-index-item",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      league: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
