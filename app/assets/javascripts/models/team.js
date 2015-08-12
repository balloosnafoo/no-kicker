NoKicker.Models.Team = Backbone.Model.extend({
  urlRoot: "/api/teams",
});

NoKicker.Models.nullTeam = new NoKicker.Models.Team({
  name: ""
})
