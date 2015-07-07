# angular
app = angular.module 'app', ['ui.router']

app.config ['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->
	$stateProvider
		.state 'view',
			url: '/view'
			templateUrl: 'view.html'
			controller: 'menuCtrl'
		.state 'edit',
			url: '/edit'
			templateUrl: 'edit.html'
			controller: 'menuCtrl'
			
	$urlRouterProvider.otherwise '/view'
	$locationProvider.html5Mode true
]

app.controller 'menuCtrl', ['$scope', '$http', ($scope, $http) ->
	$http.get('/api/menu')
		.success (data, status, headers, config) ->
			console.log "got menu:"
			console.log data
			$scope.menu = data
		.error (data, status, headers, config) ->
			console.log "error getting menu"

	$scope.addItem = (group) ->
		group.items.push {}

	$scope.deleteItem = (group, item) ->
		_.remove group.items, (i) -> i == item
	
	$scope.itemUp = (group, item) ->
		group.items.move item, -1

	$scope.itemDown = (group, item) ->
		group.items.move item, 1
	
	$scope.save = () ->
		$http.post('/api/menu', $scope.menu)
			.success (data, status, headers, config) ->
				console.log "saved menu"
			.error (data, status, headers, config) ->
				console.log "error saving menu"
]
