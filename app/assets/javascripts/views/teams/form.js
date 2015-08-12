NoKicker.Views.TeamForm = Backbone.View.extend({
  template: JST['teams/form'],

  className: "container",

  render: function () {
    var renderedContent = this.template({
      team: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
