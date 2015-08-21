NoKicker.Views.MatchupIndex = Backbone.View.extend({
  template: JST['matchups/index'],

  render: function () {
    var renderedContent = this.template({

    });

    this.$el.html(renderedContent);
    return this;
  }
});
