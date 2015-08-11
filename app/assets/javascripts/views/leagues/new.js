NoKicker.Views.LeagueNew = Backbone.View.extend({
  template: JST['leagues/new'],

  tagName: "form",

  render: function () {
    var renderedContent = this.template({
      league: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
