NoKicker.Models.Player = Backbone.Model.extend({
  urlRoot: "/api/players",

  contract: function() {
    if (!this._contract) {
      this._contract = new NoKicker.Models.PlayerContract();
    }
    return this._contract;
  },

  isContracted: function() {
    return !this.contract().isNew();
  },

  parse: function(response) {
    if (response.contract) {
      this.contract().set(response.contract);
    }
    return response;
  }

})
