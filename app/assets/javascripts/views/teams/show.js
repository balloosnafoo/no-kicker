NoKicker.Views.TeamShow = Backbone.View.extend({
  template: JST['teams/show'],

  className: "container team-show",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      team: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
