angular
.module('KnowledgeBase')
.controller('PostsEditController', function($q, $scope, $state, Restangular, post, tags, categories) {
  var removedTags = [];
  var initialTagIds = _.pluck(post.tags, 'id')

  $scope.post = post;
  $scope.tags = tags;
  $scope.categories = categories;

  /**
   * Save the post
   */
  $scope.save = function(post) {

    var copy =
     _.chain(post.tags)
      .each(function(tag){
        tag.id
          ? (tag.tag_id = tag.id)
          : (tag.tag_attributes = { name: tag.name });
      })
      .reject(function(tag){
        return _.contains(initialTagIds, tag.id);
      })
      .value();

    _.each(removedTags, function(tag){
      copy.push({
        id: tag.association_id,
        _destroy: true
      })
    });

    post.posts_tags_attributes = copy;

    $scope.post.customPUT({ post: post }).then(function(response) {
      $state.go('postsShow', { id: response.id })
    });
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

    removedTagIds = _.without(removedTagIds, tag.id);
  }

  $scope.tagRemoved = function(tag){
    if (_.contains(initialTagIds, tag.id)) {
      removedTags.push(tag)
    }
  }
});
