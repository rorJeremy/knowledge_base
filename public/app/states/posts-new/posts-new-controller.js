angular
.module('KnowledgeBase')
.controller('PostsNewController', function($scope, $http) {

  $http.get('http://localhost:3000/api/v1/categories.json').success(function(dataa) {
    $scope.categories = dataa;
  });

  // we store all the article data from the form in this object
  $scope.articleData = {};

  // function to process the form
  $scope.processForm = function() {
      alert('awesome!');
  };

});