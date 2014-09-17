angular
.module('KnowledgeBase')
.controller('PostsShowController', function($scope, $http, $stateParams, Post) {

  $scope.post = Post.get($stateParams.id).$object;

  $scope.orderProp = 'updated_at';
});