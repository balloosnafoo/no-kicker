NoKicker.Models.League = Backbone.Model.extend({
  urlRoot: "/api/leagues",

  user_team: function () {
    if (!this._user_team) {
      this._user_team = new NoKicker.Models.Team({ league: this });
    }
    return this._user_team;
  },

  parse: function (response) {
    if (response.user_team) {
      this.user_team().set(response.user_team, { parse: true });
      delete response.user_team;
    }
    return response;
  }
});
