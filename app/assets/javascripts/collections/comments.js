NoKicker.Collections.Comments = Backbone.Collection.extend({
  url: "/api/comments",

  model: NoKicker.Models.Comment
});
