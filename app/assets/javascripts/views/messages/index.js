NoKicker.Views.MessageIndex = Backbone.CompositeView.extend({
  template: JST['messages/index'],

  className: "container messages-index",

  events: {
    "click .new-message-button": "newMessage"
  },

  initialize: function (options) {
    this.league = options.league;

    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addMessage);
  },

  addMessage: function (message) {
    var messageView = new NoKicker.Views.MessageIndexItem({
      model: message,
      league: this.league
    });

    this.addSubview('.league-messages', messageView);
  },

  render: function () {
    var renderedContent = this.template({
      messages: this.collection,
      league: this.league
    });

    this.$el.html(renderedContent);
    this.renderMessages();
    return this;
  },

  renderMessages: function () {
    this.collection.each(this.addMessage.bind(this));
  },

  newMessage: function (event) {
    event.preventDefault();
    Backbone.history.navigate(
      "leagues/" + this.league.id + "/messages/new",
      { trigger: true }
    );
  }
});
