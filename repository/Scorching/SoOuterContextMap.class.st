"
I am stored in deoptimized optimized context to recover block outer contexts.
"
Class {
	#name : #SoOuterContextMap,
	#superclass : #SoAbsDeopt,
	#instVars : [
		'map'
	],
	#pools : [
		'SoMemoryManagerConstants'
	],
	#category : #'Scorching-Deoptimization'
}

{ #category : #'instance creation' }
SoOuterContextMap class >> from: deoptObjects [
	^ self new
		fromDeoptObjects: deoptObjects;
		yourself
	
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'ct 7/19/2025 04:07'
}
SoOuterContextMap >> fromDeoptObjects: deoptObjects [
	map := SoDeoptDictionary new.
	deoptObjects keysAndValuesDo: [ :key :value | 
		value class isContextClass ifTrue: [ 
			map at: key put: value ] ]
]

{ #category : #accessing }
SoOuterContextMap >> map [
	<generated>
	^ map
]

{ #category : #accessing }
SoOuterContextMap >> map: aValue [
	<generated>
	map := aValue
]
