NoKicker.Views.MessageIndex = Backbone.View.extend({
  template: JST['messages/index'],

  className: "container messages-index",

  initialize: function (options) {
    this.league = options.league
  },

  render: function () {
    var renderedContent = this.template({
      messages: this.collection,
      league: this.league
    });

    this.$el.html(renderedContent);
    return this;
  }
});
