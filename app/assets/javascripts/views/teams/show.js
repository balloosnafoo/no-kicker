NoKicker.Views.TeamShow = Backbone.CompositeView.extend({
  template: JST['teams/show'],

  className: "container team-show",

  events: {
    "change .action-selection": "updateActions",
    "click .roster-change-button": "substitutePlayers"
  },

  POSITIONAL_VALUES: {
    "qb": 0,
    "rb": 100,
    "wr": 200,
    "te": 300,
    "flex": 400,
    "dst": 500,
    "k": 600,
    "bench": 700
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
    this.openPositions();
    return this;
  },

  renderPlayers: function () {
    this.model.roster_slots().sort();
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

  // To be phased out
  toBench: function () {
    if (!this._toBench) {
      this._toBench = [];
    }
    return this._toBench;
  },

  // To be phased out
  toStart: function () {
    if (!this._toStart) {
      this._toStart = [];
    }
    return this._toStart;
  },

  // To be phased out
  firstToBench: function (rosterSlot) {
    var first = true;
    this.toBench().forEach( function (rs) {
      if (rs.escape("position") === rosterSlot.escape("position")) {
        first = false;
      }
    }.bind(this));
    return first;
  },

  openPositions: function () {
    var positions = ["qb", "wr", "rb", "te", "flex"]
    counts = this.startingPositionCounts(this.model.roster_slots());
    positions.forEach( function (pos) {
      if (!counts[pos] || counts[pos] < this.model.rosterRule().escape("num_" + pos)){
        this.addOptions(pos);
      }
    }.bind(this));
  },

  addOptions: function (slotPosition) {
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
  },

  // to be phased out
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

  // to be phased out
  getMatchingSubs: function () {
    var toBench = this.toBench().pop();
    for (var i = 0; i < this.toStart().length; i++) {
      var toStartPos = this.toStart()[i].player().escape("position").toLowerCase();
      if (toStartPos === toBench.escape("position")) {
        var toStart = this.toStart()[i]
        this.toStart().splice(i, 1);
        break;
      }
    }
    return {toBench: toBench, toStart: toStart};
  },

  // to be phased out
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

  startingPositionCounts: function (slots) {
    var counts = {};
    slots.forEach( function (slot) {
      var pos = slot.escape("position")

      // // bench slots aren't counted here
      // if (pos === "bench") {
      //   return;
      // }

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
      rosterSlot.set({
        position: "bench",
        order: this.POSITIONAL_VALUES["bench"]
      });
      rosterSlot.save({}, {
        success: this.render.bind(this),
        error: function () {debugger}.bind(this)
      });
    } else if (slotPosition === "bench") {
      var toPosition = rosterSlot.player().escape("position").toLowerCase();
      rosterSlot.set({
        position: toPosition,
        order: this.POSITIONAL_VALUES[toPosition]
      });
      rosterSlot.save({}, {
        success: this.render.bind(this),
        error: function () { debugger }.bind(this)
      });
    }
  },

  substitutePlayers: function (event) {
    event.preventDefault();
    if (!this.subsMatch()) {
      return;
    }
    while (this.toBench().length > 0) {
      subs = this.getMatchingSubs();
      this.swapSubs(subs);
    }
  },
});
