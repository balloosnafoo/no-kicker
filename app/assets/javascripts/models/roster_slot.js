NoKicker.Models.RosterSlot = Backbone.Model.extend({
  urlRoot: '/api/roster_slots',

  player: function () {
    if (!this._player) {
      this._player = new NoKicker.Models.Player();
    }
    return this._player;
  },

  parse: function (response) {
    debugger;
    if (response.player) {
      // never gets here
      this.player().set(response.player);
      delete response.player;
    }

    return this;
  }
});
