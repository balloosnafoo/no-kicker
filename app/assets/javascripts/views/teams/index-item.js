NoKicker.Views.TeamIndexItem = Backbone.View.extend({
  template: JST['teams/index_item'],

  tagName: 'tr',

  render: function () {
    var renderedContent = this.template({
      team: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
