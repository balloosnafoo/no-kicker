NoKicker.Views.MessageShow = Backbone.CompositeView.extend({
  template: JST['messages/show'],

  className: "container message-show",

  events: {
    "submit .new-comment-form": "newComment"
  },

  initialize: function (options) {
    this.league = options.league;

    this.listenTo(this.model.comments(), "add", this.addComment);
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      message: this.model,
      league: this.league
    });

    this.$el.html(renderedContent);
    this.renderComments();
    return this;
  },

  renderComments: function () {
    this.model.comments().each(this.addComment.bind(this));
  },

  addComment: function (comment) {
    var commentView = new NoKicker.Views.CommentIndexItem({
      model: comment,
      message: this.model
    });

    this.addSubview('.comments-index', commentView);
  },

  newComment: function (event) {
    event.preventDefault();
    var commentData = $(event.currentTarget).serializeJSON().comment
    var comment = new NoKicker.Models.Comment(commentData);
    comment.set({
      league_id: this.league.id,
      message_id: this.model.id
    });
    comment.save({}, {
      success: function () {
        this.model.comments().add(comment, { merge: true });
        this.render();
      }.bind(this)
    });
  }
});
