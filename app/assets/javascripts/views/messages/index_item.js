NoKicker.Views.MessageIndexItem = Backbone.View.extend({
  template: JST['messages/index_item'],

  tagName: "li",

  class: "message-item",

  render: function () {
    var renderedContent = this.template({
      message: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
