NoKicker.Collections.Leagues = Backbone.Collection.extend({
  url: "/api/leagues",

  model: NoKicker.Models.League,

  // Read about mixins and refactor this out!
  getOrFetch: function (id) {
    var collection = this;
    var widget = collection.get(id);

    if (widget) {
      widget.fetch();
    } else {
      widget = new collection.model({ id: id });
      collection.fetch({
        error: function () { collection.remove(widget); }
      });
    }
    return widget;
  }
});
