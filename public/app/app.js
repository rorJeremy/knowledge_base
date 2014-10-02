'use strict';

(function(){

  var app = angular.module('KnowledgeBase', ['ngResource', 'ui.router', 'restangular', 'ngTagsInput']);

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
        controller: 'PostsNewController',
        resolve: {
          tags: function(Tag) {
            return Tag.getList();
          },
          categories: function(Category) {
            return Category.getList();
          }
        }
      })
      .state("postsEdit", {
        url: '/posts/edit/:id',
        templateUrl: 'app/states/posts-edit/posts-edit.html',
        controller: 'PostsEditController',
        resolve: {
          post: function($stateParams, Post){
            return Post.get($stateParams.id);
          },
          tags: function(Tag) {
            return Tag.getList();
          },
          categories: function(Category) {
            return Category.getList();
          }
        }
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
