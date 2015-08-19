NoKicker.Views.MessageShow = Backbone.View.extend({
  template: JST['messages/show'],

  className: "container message-show",

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
