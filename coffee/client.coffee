# angular
app = angular.module 'app', ['ui.router']

app.config ['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->
	$stateProvider
		.state 'view',
			url: '/view'
			templateUrl: 'view.html'
			controller: 'viewCtrl'
		.state 'edit',
			url: '/edit'
			templateUrl: 'edit.html'
			controller: 'editCtrl'
			
	$urlRouterProvider.otherwise '/view'
	$locationProvider.html5Mode true
]

app.controller 'viewCtrl', ['$scope', '$http', ($scope, $http) ->
	console.log "hello"
	$http.get('/api/menu')
		.success (data, status, headers, config) ->
			console.log "got menu:"
			console.log data
			$scope.menu = data
		.error (data, status, headers, config) ->
			console.log "error getting menu"
]

app.controller 'editCtrl', ['$scope', '$http', ($scope, $http) ->
]