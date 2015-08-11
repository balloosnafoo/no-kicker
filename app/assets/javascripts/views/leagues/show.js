NoKicker.Views.LeagueShow = Backbone.CompositeView.extend({
  template: JST['leagues/show'],

  className: "container",

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
