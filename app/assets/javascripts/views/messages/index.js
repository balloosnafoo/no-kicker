NoKicker.Views.MessageIndex = Backbone.CompositeView.extend({
  template: JST['messages/index'],

  className: "container messages-index",

  events: {
    "submit .new-message-form": "newMessage"
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
    var formData = $(event.currentTarget).serializeJSON();
    var message = new NoKicker.Models.Message(formData.message);
    message.set({ league_id: this.league.id });
    message.save({}, {
      success: function () {
        this.collection.add(message);
      }.bind(this)
    })
  }
});
