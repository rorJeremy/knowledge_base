angular
.module('KnowledgeBase')
.controller('HomeIndexController', function($scope, Restangular) {

  var basePosts = Restangular.all('posts');
  basePosts.getList().then(function(posts) {
    $scope.posts = posts;
  });

  var baseCategories = Restangular.all('categories');
  baseCategories.getList().then(function(categories) {
    $scope.categories = categories;
  });

  // $scope.tag = function(message) {
  //   if ($scope.tags) {
  //     var myArray = [];
  //     return $scope.tags.replace(/\s*,\s*/g, ',').split(',').every(function(tag) {
  //       var arrayLength = message.tags.length;
  //       for (var i = 0; i < arrayLength; i++) {
  //         myArray.push(message.tags[i]["name"]);}
  //         myArray.toString();
  //       return myArray.some(function(objTag){
  //         return objTag.indexOf(tag) !== -1;
  //       });
  //     });
  //   }
  //   else {
  //     return true;
  //   }
  // };

  $scope.orderProp = 'updated_at';

});