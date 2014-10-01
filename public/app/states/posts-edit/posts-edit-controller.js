angular
.module('KnowledgeBase')
.controller('PostsEditController', function($scope, $q, $location, Restangular, post) {


  console.log("helloooooooooooo");
  console.log(post);
  console.log("worldddddddddddd");
  var originalPost = post;
  var originalTags = _.pluck(post.tags, "name");
  console.log("originaltags");
  console.log(originalTags);

  $scope.post = Restangular.copy(originalPost);



  // $scope.tags = [];


  var baseCategories = Restangular.all('categories');
  baseCategories.getList().then(function(categories) {
    $scope.categories = categories;
  });


  // $scope.$watchCollection('post.tags', function(newCollection){
  //   _.each(newCollection, function(item){
  //     console.log("scope.tags:::");
  //     console.log($scope.tags);
  //     var existingTag = _.findWhere($scope.tags, { name: item.name });
  //     if (existingTag) {
  //       item.tag_id = existingTag.id
  //       console.log("this is aaaaa");
  //       console.log(item, existingTag);
  //       console.log("existing taggggg");
  //     }
  //     else {
  //       console.log("item at first: ");
  //       console.log(item);
  //       console.log("and then item turns into: ");
  //       item.tags = { name: item.name };
  //       console.log(item);
  //     }
  //   });
  // })

  $scope.loadTags = function(){
    var promise = Restangular.all('tags').getList();
    promise.then(function(tags){
      $scope.tags = tags;


      $scope.$watchCollection('post.tags', function(newCollection){
        _.each(newCollection, function(item){
          console.log("scope.tags:::");
          console.log($scope.tags);
          var existingTag = _.findWhere($scope.tags, { name: item.name });
          if (existingTag) {
            item.tag_id = existingTag.id
            console.log("this is aaaaa");
            console.log(item, existingTag);
            console.log("existing taggggg");
          }
          else {
            console.log("item at first: ");
            console.log(item);
            console.log("and then item turns into: ");
            item.tag_attributes = { name: item.name };
            console.log(item);
          }
        });
      })


    })

    return promise;
  }


  $scope.save = function() {
    console.log("hereeee");
    console.log($scope.post);
    console.log("and hereeeee");
    console.log($scope.post.posts_tags_attributes);
    $scope.post.customPUT({post: $scope.post}).then(function() {
      $location.path('/home');
    });
  };

});