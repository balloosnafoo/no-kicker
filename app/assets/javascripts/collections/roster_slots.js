NoKicker.Collections.RosterSlots = Backbone.Collection.extend({
  url: "/api/roster_slots",

  model: NoKicker.Models.RosterSlot,

  comparator: function (rosterSlot) {
    return rosterSlot.get("order");
  },
});
