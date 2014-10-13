angular
.module('KnowledgeBase')
.controller('CategoriesNewController', function($scope, $state, Restangular, Category) {

  /**
   * Save the category
   */
  $scope.save = function(category) {

    Category.post({ category: category }).then(function(response){
      $state.go('postsNew')
    });

    return false;
  };

});
