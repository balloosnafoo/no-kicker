NoKicker.Views.TeamForm = Backbone.View.extend({
  template: JST['teams/form'],

  className: "container",

  events: {
    "submit form": "newTeam"
  },

  render: function () {
    var renderedContent = this.template({
      team: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  newTeam: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    var team = new NoKicker.Models.Team()

    team.set(formData.team);
    team.set({division: 1})
    team.save({}, {
      success: function () {
        Backbone.history.navigate(
          "leagues/" + team.escape("league_id"),
          { trigger: true }
        );
      }.bind(this)
    });
  }
});
