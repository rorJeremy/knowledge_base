angular
.module('KnowledgeBase')
.controller('PostsNewController', function($q, $scope, $state, Restangular, Post, tags, categories) {
  $scope.tags = tags;
  $scope.categories = categories;

  /**
   * Save the post
   */
  $scope.save = function(post) {

    var copy = angular.copy(post.tags);

    // Transform the tags result depending on existing or new.
    _.each(copy, function(tag){
      tag.id
        ? (tag.tag_id = tag.id)
        : (tag.tag_attributes = { name: tag.name });

      delete tag.id;
      delete tag.name;
    });

    post.posts_tags_attributes = copy;

    Post.post({ post: post }).then(function(response){
      $state.go('postsShow', { id: response.id })
    });

    return false;
  };

  /**
   * Provides a promise that resolves with tags to the autocompleter.
   */
  $scope.tagSource = function(){
    var deferred = $q.defer();
    deferred.resolve($scope.tags);
    return deferred.promise;
  }

  /**
   * When tags are added, check for a pre-existing tag and copy the id.
   */
  $scope.tagAdded = function(tag){
    if (!tag.id) {
      var existing = _.findWhere(tags, { name: tag.name });
      existing && (tag.id = existing.id);
    }
  }

  /**
   * When tags are added, check for a pre-existing tag and copy the id.
   */
  $scope.tagAdded = function(tag){
    if (!tag.id) {
      var existing = _.findWhere(tags, { name: tag.name });
      existing && (tag.id = existing.id);
    }
  }
});
