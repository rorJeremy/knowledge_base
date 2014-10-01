angular
.module('KnowledgeBase')
.controller('PostsNewController', function($scope, $q, $location, Restangular) {
  $scope.tags = [];


  var basePosts = Restangular.all('posts');

  var baseCategories = Restangular.all('categories');
  baseCategories.getList().then(function(categories) {
    $scope.categories = categories;
  });

  // we store all the post data from the form in this object
  $scope.articleData = {};

  $scope.$watchCollection('articleData.post.posts_tags_attributes', function(newCollection){
    _.each(newCollection, function(item){
      var existingTag = _.findWhere($scope.tags, { name: item.name });
      if (existingTag) {
        item.tag_id = existingTag.id
        console.log(item, existingTag)
      }
      else {
        item.tag_attributes = { name: item.name };
      }
    });
  })

  $scope.loadTags = function(){
    var promise = Restangular.all('tags').getList();

    $scope.tags = promise.$object;

    return promise;
  }


  // function to process the form
  $scope.processForm = function() {
    basePosts.post($scope.articleData).then(function(articleData) {
      $location.path('/posts/' + articleData.id.toString());
    });
  };

});