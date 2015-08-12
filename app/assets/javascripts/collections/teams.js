NoKicker.Collections.Teams = Backbone.Collection.extend({
  url: "/api/teams",

  model: NoKicker.Models.Team
});
