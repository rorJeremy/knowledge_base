angular
.module('KnowledgeBase')
.controller('HomeIndexController', function($scope, $http) {
  $http.get('http://localhost:3000/api/v1/posts.json').success(function(data) {
    $scope.posts = data;
  });

  $http.get('http://localhost:3000/api/v1/categories.json').success(function(dataa) {
    $scope.categories = dataa;
  });

  $scope.tag = function(message) {
    if ($scope.tags) {
      var myArray = [];
      return $scope.tags.replace(/\s*,\s*/g, ',').split(',').every(function(tag) {
        var arrayLength = message.tags.length;
        for (var i = 0; i < arrayLength; i++) {
          myArray.push(message.tags[i]["name"]);}
          myArray.toString();
        return myArray.some(function(objTag){
          return objTag.indexOf(tag) !== -1;
        });
      });
    }
    else {
      return true;
    }
  };

  $scope.orderProp = 'updated_at';

});