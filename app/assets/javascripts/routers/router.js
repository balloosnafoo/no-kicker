NoKicker.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.leagues  = options.leagues;
    this.$rootEl  = options.$rootEl;
    this.players  = new NoKicker.Collections.Players();
    this.teams    = new NoKicker.Collections.Teams();
    this.messages = new NoKicker.Collections.Messages();
  },

  routes: {
    "": "userLeagueIndex",
    "leagues/all": "leagueIndex",
    "leagues/new": "leagueNew",
    "leagues/:id": "leagueShow",
    "leagues/:league_id/teams/new": "teamNew",
    "leagues/:league_id/teams/:team_id": "teamShow",
    "leagues/:league_id/players": "playerIndex",
    "leagues/:league_id/add/:player_id": "addPlayer",
    "leagues/:league_id/messages": "messageIndex",
    "leagues/:league_id/messages/new": "messageNew",
    "leagues/:league_id/messages/:message_id": "messageShow",
    "leagues/:league_id/trades": "tradeIndex",
    "leagues/:league_id/trades/new": "tradeNew",
    "leagues/:league_id/trades/:partner_id": "tradeCustomize",
    "leagues/:league_id/matchups": "matchupIndex"
  },

  userLeagueIndex: function () {
    this.leagues.fetch({ data: { user_leagues: true } });
    var indexView = new NoKicker.Views.LeagueIndex({
      collection: this.leagues
    });

    this._swapView(indexView);
  },

  leagueIndex: function () {
    this.leagues.fetch();
    var indexView = new NoKicker.Views.LeagueAllIndex({
      collection: this.leagues
    });

    this._swapView(indexView);
  },

  leagueNew: function () {
    var league = new NoKicker.Models.League();
    var newView = new NoKicker.Views.LeagueNew({
      model: league,
      collection: this.leagues
    });

    this._swapView(newView);
  },

  leagueShow: function (id) {
    var league = this.leagues.getOrFetch(id);
    var showView = new NoKicker.Views.LeagueShow({
      model: league
    });

    this._swapView(showView);
  },

  teamNew: function (league_id) {
    var team = new NoKicker.Models.Team({league_id: league_id});
    var formView = new NoKicker.Views.TeamForm({
      model: team
    });

    this._swapView(formView);
  },

  teamShow: function (league_id, team_id) {
    var teams = new NoKicker.Collections.Teams();
    var team = teams.getOrFetch(team_id);
    var showView = new NoKicker.Views.TeamShow({
      model: team
    });

    this._swapView(showView);
  },

  playerIndex: function (league_id) {
    var players = new NoKicker.Collections.Players();
    players.fetch({ data: { league_id: league_id } });
    var indexView = new NoKicker.Views.PlayerIndex({
      collection: players,
      league: this.leagues.getOrFetch(league_id)
    });

    this._swapView(indexView);
  },

  addPlayer: function (league_id, player_id) {
    var league = this.leagues.getOrFetch(league_id, { user_team: true });
    var player = this.players.getOrFetch(player_id);
    var addView = new NoKicker.Views.TeamAddDrop({
      league: league,
      toAddPlayer: player
    });

    this._swapView(addView);
  },

  messageIndex: function (league_id) {
    var league = this.leagues.getOrFetch(league_id);
    this.messages.fetch({data: {league_id: league_id}});
    var indexView = new NoKicker.Views.MessageIndex({
      collection: this.messages,
      league: league
    });

    this._swapView(indexView);
  },

  messageNew: function (league_id) {
    var league = this.leagues.getOrFetch(league_id);
    var message = new NoKicker.Models.Message();
    var formView = new NoKicker.Views.MessageForm({
      model: message,
      collection: this.messages,
      league: league
    });

    this._swapView(formView);
  },

  messageShow: function (league_id, message_id) {
    var league = this.leagues.getOrFetch(league_id);
    var message = this.messages.getOrFetch(message_id);
    var showView = new NoKicker.Views.MessageShow({
      model: message,
      collection: this.messages,
      league: league
    });

    this._swapView(showView);
  },

  tradeIndex: function (league_id) {
    var league = this.leagues.getOrFetch(league_id, { user_team: true });
    var tradeOffers = new NoKicker.Collections.TradeOffers();
    tradeOffers.fetch({data: {league_id: league_id}});

    var indexView = new NoKicker.Views.TradeOfferIndex({
      league: league,
      collection: tradeOffers
    });

    this._swapView(indexView);
  },

  tradeNew: function (league_id) {
    var league = this.leagues.getOrFetch(league_id);
    var tradeView = new NoKicker.Views.TradeOfferPartnerSelect({
      league: league,
    });

    this._swapView(tradeView);
  },

  tradeCustomize: function (league_id, partner_id) {
    var league = this.leagues.getOrFetch(league_id, {
      user_team: true,
      roster_slots: true
    });
    var partner = this.teams.getOrFetch(partner_id);

    var tradeView = new NoKicker.Views.TradeOfferItemsSelect({
      partner: partner,
      league: league
    });

    this._swapView(tradeView);
  },

  matchupIndex: function (league_id) {
    var league = this.leagues.getOrFetch(league_id);
    var matchups = new NoKicker.Collections.Matchups();
    matchups.fetch({ league_id: league_id });

    var indexView = new NoKicker.Views.MatchupIndex({
      league: league,
      collection: matchups
    });

    this._swapView(indexView);
  },

  _swapView: function (view) {
    this._view && this._view.remove();
    this._view = view;
    this.$rootEl.html(view.render().$el);
  }
});
