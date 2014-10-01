angular
.module('KnowledgeBase')
.factory('Category', function(Restangular) {
  return Restangular.all('tags');
});
