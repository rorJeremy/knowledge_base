angular
.module('KnowledgeBase')
.controller('PostsShowController', function($scope, $state, $stateParams, Post) {

  $scope.post = Post.get($stateParams.id).$object;

  $scope.destroy = function(post) {
    post.remove();
    $state.go('home');
  }
});
