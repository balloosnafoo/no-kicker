NoKicker.Collections.Messages = Backbone.Collection.extend({
  url: "/api/messages",

  model: NoKicker.Models.Message
});
