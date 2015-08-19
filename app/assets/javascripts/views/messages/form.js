NoKicker.Views.MessageForm = Backbone.View.extend({
  template: JST['messages/form'],

  className: "container",

  events: {
    "submit .new-message-form": "newMessage"
  },

  initialize: function (options) {
    this.league = options.league;
  },

  render: function () {
    var renderedContent = this.template({
      message: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  newMessage: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    var message = new NoKicker.Models.Message(formData.message);
    message.set({ league_id: this.league.id });
    message.save({}, {
      success: function () {
        this.collection.add(message);
        Backbone.history.navigate(
          "leagues/" + this.league.id + "/messages",
          { trigger: true }
        );
      }.bind(this)
    })
  }
});
