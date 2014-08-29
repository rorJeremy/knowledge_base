// angular
//   .module('app', ['ngRoute', 'ngResource'])
//   .config(['$routeProvider', function($routeProvider){
//     $routeProvider.when('/', {
//       templateUrl: 'app/partials/post_list.html.erb',
//       controller: 'HomeCtrl'
//     }).when('/posts/:id', {
//       templateUrl: 'partials/post_detail.html.erb',
//       controller: 'PostDetailCtrl'
//     }).otherwise({
//       redirectTo: '/'
//     });
//   }]);

'use strict';

/* App Module */

var kbApp = angular.module('app', [
  'ngRoute',
  'ngResource'
]);

kbApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'partials/post_list.html.erb',
        controller: 'MainCtrl'
      }).
      when('/posts/:id', {
        templateUrl: 'partials/post_detail.html.erb',
        controller: 'PostDetailCtrl'
      }).
      otherwise({
        redirectTo: '/'
      });
  }]);