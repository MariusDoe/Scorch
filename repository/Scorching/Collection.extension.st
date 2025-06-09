Extension { #name : #Collection }

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 16:43'
}
Collection >> asDictionary [
	^ self as: Dictionary
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 16:43'
}
Collection >> flatCollect: aBlock [
	^ self gather: aBlock
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:15'
}
Collection >> includesAll: aCollection [
	^ self includesAllOf: aCollection
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 16:44'
}
Collection >> includesAny: anArray [ 
	^ self includesAnyOf: anArray
]
