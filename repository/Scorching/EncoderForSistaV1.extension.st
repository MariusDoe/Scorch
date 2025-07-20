Extension { #name : #EncoderForSistaV1 }

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:42'
}
EncoderForSistaV1 class >> backJumpBytecodeSize [
	^ 4
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
	#'squeak_changestamp' : 'mad 7/20/2025 14:49'
}
EncoderForSistaV1 class >> specialLiterals [
	^ #(true false nil), (-32768 to: 32767), ((0 to: 65535) collect: [:each | Character value: each])
]
