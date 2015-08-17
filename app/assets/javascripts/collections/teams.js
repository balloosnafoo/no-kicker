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
        success: function () { collection.add(widget); }
      });
    }
    
    return widget;
  }
});
