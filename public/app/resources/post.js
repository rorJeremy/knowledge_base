angular
.module('KnowledgeBase')
.factory('Post', function(Restangular) {
  return Restangular.all('posts');
});
