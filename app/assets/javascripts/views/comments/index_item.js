NoKicker.Views.CommentIndexItem = Backbone.View.extend({
  template: JST['comments/index_item'],

  tagName: "li",

  className: "comment-index-item",

  initialize: function (options) {
    this.message = options.message;
  },

  render: function () {
    var renderedContent = this.template({
      comment: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
