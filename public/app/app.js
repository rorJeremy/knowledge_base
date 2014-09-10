'use strict';

(function(){

  var app = angular.module('KnowledgeBase', ['ngResource', 'ui.router', 'restangular']);

  app.config(function($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state("home", {
        url: '/home',
        templateUrl: 'app/states/home-index/home-index.html',
        controller: 'HomeIndexController'
      })
      .state("postsNew", {
        url: '/posts/new',
        templateUrl: 'app/states/posts-new/posts-new.html',
        controller: 'PostsNewController'
      })
      .state("postsShow", {
        url: '/posts/:id',
        templateUrl: 'app/states/posts-show/posts-show.html',
        controller: 'PostsShowController'
      })

    $urlRouterProvider.otherwise('/home');
  });

  app.config(function(RestangularProvider) {
    RestangularProvider.setBaseUrl('/api/v1');
    RestangularProvider.setRequestSuffix('.json');
  });

})();

