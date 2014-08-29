'use strict';

/* Controllers */

var kbApp = angular.module('app', []);

kbApp.controller('PostDetailCtrl', function($scope, $http) {
  $http.get('http://localhost:3000/api/v1/posts/:id.json').success(function(data) {
    $scope.posts = data;
  });

  $scope.orderProp = 'updated_at';
});