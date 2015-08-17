NoKicker.Collections.Players = Backbone.Collection.extend({
  url: "/api/players",

  model: NoKicker.Models.Player,

  getOrFetch: function (id) {
    var collection = this;
    var widget = collection.get(id);

    if (widget) {
      widget.fetch();
    } else {
      widget = new collection.model({ id: id });
      collection.add(widget);
      widget.fetch({
        error: function () { collection.remove(widget); }
      });
    }
    return widget;
  }
});
