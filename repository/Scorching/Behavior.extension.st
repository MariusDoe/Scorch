Extension { #name : #Behavior }

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'mad 6/5/2025 15:12'
}
Behavior >> allowRuntimeOptimization [
	^ true
]

{
	#category : #'*Scorching-testing-pseudo-override',
	#'squeak_changestamp' : 'ct 7/19/2025 04:00'
}
Behavior >> isContextClass [

	^ false
]
