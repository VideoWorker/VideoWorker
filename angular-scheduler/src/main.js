import angular from 'angular'
import ngMaterial from 'angular-material'

import { config } from './main.config.js'

console.log(ngMaterial)
console.log(config)

var app = angular.module('schedulerApp', [ngMaterial])

app.component('main', {
  templateUrl: 'main.html'
})
