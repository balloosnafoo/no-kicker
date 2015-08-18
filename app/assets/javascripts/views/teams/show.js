NoKicker.Views.TeamShow = Backbone.CompositeView.extend({
  template: JST['teams/show'],

  className: "container team-show",

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
    this.renderPlayersRS();
    return this;
  },

  renderPlayersRS: function () {
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
});
