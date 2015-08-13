NoKicker.Views.LeagueAllIndex = Backbone.View.extend({
  template: JST['leagues/all_index'],

  className: "container all-leagues-index",

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      leagues: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  }
});
