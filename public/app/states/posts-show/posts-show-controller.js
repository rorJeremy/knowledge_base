angular
.module('KnowledgeBase')
.controller('PostsShowController', function($scope, $http, $stateParams, Restangular, Post) {

  $scope.post = Post.get($stateParams.id).$object;

  // Restangular.one('posts', $stateParams.id).get().then(function(post){

  //   $scope.post = post;

  // });

  $scope.remove = function(item) {
    item.remove();
  }

  $scope.orderProp = 'updated_at';
});