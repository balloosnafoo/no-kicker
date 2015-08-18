NoKicker.Views.TeamShow = Backbone.CompositeView.extend({
  template: JST['teams/show'],

  className: "container team-show",

  events: {
    "change .action-selection": "updateActions"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.roster_slots(), "add", this.addItem);
  },

  render: function () {
    var renderedContent = this.template({
      team: this.model
    });

    this._rendered_bench = false;
    this.$el.html(renderedContent);
    this.renderPlayers();
    return this;
  },

  renderPlayers: function () {
    this.model.roster_slots().each(this.addItem.bind(this));
  },

  addItem: function (roster_slot) {
    if (roster_slot.escape("position") === "bench" && !this._rendered_bench) {
      // render line break
      this.$('.roster-table').append("<tr><td colspan='12'><h3>Bench</h3></td></tr>")
      this._rendered_bench = true;
    }

    var playersView = new NoKicker.Views.RosterSlotTeamIndexItem({
      model: roster_slot,
      team: this.model
    });

    this.addSubview('.roster-table', playersView);
  },

  toBench: function () {
    if (!this._toBench) {
      this._toBench = [];
    }
    return this._toBench;
  },

  toStart: function () {
    if (!this._toStart) {
      this._toStart = [];
    }
    return this._toStart;
  },

  firstToBench: function (rosterSlot) {
    var first = true;
    this.toBench().forEach( function (rs) {
      if (rs.escape("position") === rosterSlot.escape("position")) {
        first = false;
      }
    }.bind(this));
    return first;
  },

  subsMatch: function () {
    var result = true;
    var benchHash = this.subsPositionHash(this.toBench());
    var startHash = this.subsPositionHash(this.toStart());
    
    Object.keys(benchHash).forEach( function (key) {
      if (benchHash[key] !== startHash[key]) {
        result = false;
      }
    }.bind(this));

    return result;
  },

  subsPositionHash: function (subs) {
    var counts = {};
    subs.forEach( function (sub) {
      var pos = sub.escape("position")

      // pos needs to come from player for bench slots.
      if (pos === "bench") {
        pos = sub.player().escape("position").toLowerCase();
      }

      // increment or create count at 1
      if (!counts[pos]) {
        counts[pos] =  1;
      } else {
        counts[pos] += 1;
      }
    }.bind(this));

    return counts;
  },

  updateActions: function (event) {
    var rosterSlotId = $(event.currentTarget).data().rosterSlotId;
    var rosterSlot = this.model.roster_slots().get(rosterSlotId);
    var slotPosition = rosterSlot.escape("position");
    var moveTo = $(event.currentTarget).val();

    if (moveTo === "bench" && this.firstToBench(rosterSlot)) {
      this.toBench().push(rosterSlot);
      this.model.roster_slots().each( function (roster_slot) {
        if (
          roster_slot.escape("position") === "bench" &&
          roster_slot.player().escape("position").toLowerCase() === slotPosition
        ) {
          selection = this.$('*[data-roster-slot-id="' + roster_slot.id + '"]');
          selection.append(
            "<option value='" + slotPosition + "'>" + slotPosition + "</option>"
          )
        }
      }.bind(this));
    } else if (slotPosition === "bench") {
      this.toStart().push(rosterSlot);
    }
    debugger;
  }
});
