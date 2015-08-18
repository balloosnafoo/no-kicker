NoKicker.Collections.Leagues = Backbone.Collection.extend({
  url: "/api/leagues",

  model: NoKicker.Models.League,

  // Read about mixins and refactor this out!
  getOrFetch: function (id, dataOptions) {
    var collection = this;
    var widget = collection.get(id);

    if (widget) {
      widget.fetch({data: dataOptions});
    } else {
      widget = new collection.model({ id: id });
      collection.add(widget);
      widget.fetch({
        error: function () { collection.remove(widget); },
        data: dataOptions
      });
    }
    return widget;
  }
});
