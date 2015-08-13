NoKicker.Collections.PlayerContracts = Backbone.Collection.extend({
  url: "/api/player_contracts",

  model: NoKicker.Models.PlayerContract,

  getOrFetch: function (id) {
    var collection = this;
    var widget = collection.get(id);

    if (widget) {
      widget.fetch();
    } else {
      widget = new collection.model({ id: id });
      widget.fetch({
        error: function () { collection.remove(widget); }
      });
    }
    return widget;
  }
});
