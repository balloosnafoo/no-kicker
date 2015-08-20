NoKicker.Views.MessageIndexItem = Backbone.View.extend({
  template: JST['messages/index_item'],

  tagName: "li",

  className: "message-item list-group-item",

  initialize: function (options) {
    this.league = options.league;
  },

  render: function () {
    var renderedContent = this.template({
      message: this.model,
      league: this.league
    });

    this.$el.html(renderedContent);
    return this;
  }
});
