angular
.module('KnowledgeBase')
.factory('Tag', function(Restangular) {
  return Restangular.all('tags');
});
