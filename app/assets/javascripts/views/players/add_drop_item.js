NoKicker.Views.PlayerAddDropItem = Backbone.View.extend({
  template: JST['players/add_drop_item'],

  tagName: "tr",

  className: 'add-drop-item',

  render: function () {
    var renderedContent = this.template({
      player: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
