NoKicker.Collections.Teams = Backbone.Collection.extend({
  url: "/api/teams",

  model: NoKicker.Models.Team,

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
