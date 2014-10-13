angular
.module('KnowledgeBase')
.controller('PostsShowController', function($scope, $state, Restangular, post, categories) {


  $scope.post = post;

  categories.forEach(function(category) {
    if (category.id == post.category_id){
      $scope.category = category;
    }
  });

  $scope.destroy = function(post) {
    post.remove();
    $state.go('home');
  }
});
