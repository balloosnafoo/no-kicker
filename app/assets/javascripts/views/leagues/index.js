NoKicker.Views.LeagueIndex = Backbone.CompositeView.extend({
  template: JST['leagues/index'],

  className: "container",

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    debugger;
    var renderedContent = this.template({
      leagues: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  }
});
