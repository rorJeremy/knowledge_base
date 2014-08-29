// angular
//   .module('app')
//   .controller('MainCtrl', ['Post', '$scope', '$routeParams',
//     function(Post, $scope, $routeParams){
//       $scope.posts = Post.query();
//       $scope.$on('$routeChangeSuccess', function () {
//         var status = $scope.status = $routeParams.status || '';

//         $scope.statusFilter = (status === 'active') ?
//         { completed: false } : (status === 'completed') ?
//         { completed: true } : null;
//       });

//       var uncompletedPosts;

//       $scope.activePost = new Post();
//       $scope.checked = false;
//       $scope.edit = function(post) {
//         $scope.activePost = post;
//       };

//       $scope.checkAll = function(checked) {
//         _.each($scope.posts, function(post) { $scope.checkAndSave(post, checked); })
//       };

//       $scope.checkAndSave = function(post, checked) {
//         post.completed = checked || !!(!post.completed);
//         $scope.save(post);
//       };

//       $scope.save = function(post) {
//         if (!_.include($scope.posts, post)) {
//           $scope.posts.push(post);
//           post.$save();
//         } else {
//           Post.update(post);
//         }
//         updateRemainingPostCount();
//         $scope.activePost = new Post();
//       };

//     }])

'use strict';

/* Controllers */

var kbApp = angular.module('app', []);

kbApp.controller('MainCtrl', function($scope, $http) {
  $http.get('http://localhost:3000/api/v1/posts.json').success(function(data) {
    $scope.posts = data;
  });

  $scope.orderProp = 'updated_at';
});







// 'use strict';

// /* Controllers */

// var kbControllers = angular.module('kbControllers', []);

// kbControllers.controller('MainCtrl', ['$scope', '$http',
//   function($scope, $http) {
//     $http.get('http://localhost:3000/api/v1/posts.json').success(function(data) {
//       $scope.posts = data;
//     });

//     $scope.orderProp = 'updated_at';
//   }]);

// kbControllers.controller('PostDetailCtrl', ['$scope', '$routeParams',
//   function($scope, $routeParams) {
//     $scope.postId = $routeParams.postId;
//   }]);








// var kbApp = angular.module('app', []);

// kbApp.controller('MainCtrl', function ($scope) {

//   $scope.posts = [
//     {
//       'title': 'Some Question',
//       'body': 'Stuff about card printerrrr!',
//       'age': 1
//     },
//     {
//       'title': 'Some Topic',
//       'body': 'Stuff about KPSSSSSS!',
//       'age': 2
//     }
//   ];

//   $scope.orderProp = 'age';
// });