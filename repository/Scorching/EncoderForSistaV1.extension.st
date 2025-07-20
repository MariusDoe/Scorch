Extension { #name : #EncoderForSistaV1 }

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:42'
}
EncoderForSistaV1 class >> backJumpBytecodeSize [
	^ 4
]

{ #category : #'*Scorching' }
EncoderForSistaV1 >> genBranchIfInstanceOf: literalIndex distance: distance [
	self genBranchIfInstanceOf: literalIndex distance: distance orNot: false
]

{ #category : #'*Scorching' }
EncoderForSistaV1 >> genBranchIfInstanceOf: literalIndex distance: distance orNot: orNot [
	"254		11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0)"
							
	| extendedIndex extendedDistance |
	(literalIndex < 0 or: [literalIndex > 65535]) ifTrue:
		[^self outOfRangeError: 'index' index: literalIndex range: 0 to: 65536].
	(distance < 1 or: [distance > 32767]) ifTrue: 
		[^self outOfRangeError: 'distance' index: distance range: 0 to: 32767].
	(extendedIndex := literalIndex) > 255 ifTrue:
		[self genUnsignedSingleExtendA: extendedIndex // 256.
		 extendedIndex := extendedIndex \\ 256].
	(orNot not or: [(extendedDistance := distance) > 255]) ifTrue:
		[self genUnsignedSingleExtendB: (distance bitShift: -8) + (orNot not asBit  * 128).
		extendedDistance := distance bitAnd: 255].
	
	stream
		nextPut: 254;
		nextPut: extendedIndex;
		nextPut: extendedDistance
]

{ #category : #'*Scorching' }
EncoderForSistaV1 >> genBranchIfNotInstanceOf: literalIndex distance: distance [
	self genBranchIfInstanceOf: literalIndex distance: distance orNot: true
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:41'
}
EncoderForSistaV1 >> genPushFullClosure: compiledBlockLiteralIndex
numCopied: numCopied
receiverOnStack: receiverOnStack
outerContextNeeded: outerContextNeeded [
	^ self
		genPushFullClosure: compiledBlockLiteralIndex
		numCopied: numCopied
		receiverOnStack: receiverOnStack
		ignoreOuterContext: outerContextNeeded not
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 17:19'
}
EncoderForSistaV1 >> genPushRemoteInstanceVariable: instVarIndex inObjectAt: objectIndex [
	^ self genPushRemoteTemp: instVarIndex + (1 << 7) inVectorAt: objectIndex
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 17:25'
}
EncoderForSistaV1 >> genStorePopRemoteInstanceVariable: instVarIndex inObjectAt: objectIndex [
	^ self genStorePopRemoteTemp: instVarIndex + (1 << 7) inVectorAt: objectIndex
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 17:20'
}
EncoderForSistaV1 >> genTrap [
	"217		11011001			Unconditionnal trap"
	stream nextPut: 217
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:37'
}
EncoderForSistaV1 class >> specialLiterals [
	^ #(true false nil 0 1)
]
