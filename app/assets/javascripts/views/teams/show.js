NoKicker.Views.TeamShow = Backbone.CompositeView.extend({
  template: JST['teams/show'],

  className: "container-fluid team-show",

  events: {
    "change .roster-change-select": "updateActions",
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
      // render table separator
      this.$('.roster-table').append(
        "<tr><th class='vertical-spacer table-heading' colspan='12'><h3>Bench</h3></th></tr>"
      )
      this._rendered_bench = true;
    }

    var playersView = new NoKicker.Views.RosterSlotTeamIndexItem({
      model: roster_slot,
      team: this.model
    });

    this.addSubview('.roster-table', playersView);
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
        (
          roster_slot.player().escape("position").toLowerCase() === slotPosition ||
          ["rb", "wr", "te"].indexOf(roster_slot.player().escape("position").toLowerCase()) !== -1
        )
      ) {
        selection = this.$('*[data-roster-slot-id="' + roster_slot.id + '"]');
        selection.append(
          "<option value='" + slotPosition + "'>" + slotPosition + "</option>"
        )
      }
    }.bind(this));
  },

  startingPositionCounts: function (slots) {
    var counts = {};
    slots.forEach( function (slot) {
      var pos = slot.escape("position")
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

    if (moveTo === "bench") {
      rosterSlot.set({
        position: "bench",
        order: this.POSITIONAL_VALUES["bench"]
      });
      rosterSlot.save({}, {
        success: this.render.bind(this),
        error: function () {debugger}.bind(this)
      });
    } else if (slotPosition === "bench") {
      // debugger;
      // var toPosition = rosterSlot.player().escape("position").toLowerCase();
      var toPosition = moveTo;
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
});
