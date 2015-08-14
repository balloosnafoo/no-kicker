NoKicker.Views.TeamAddDrop = Backbone.View.extend({
  template: JST['teams/add_drop'],

  className: "container add-drop-form",

  render: function () {
    var renderedContent = this.template({
      team: this.collection
      // addition:
    });

    this.$el.html(renderedContent);
    return this;
  }
});
