!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AF 4/27/2022 16:57:22'!
test01EmptyFinderShouldReturnEmpty
	"Aca no se como podriamos generalizar el prefijo que le pasan para testear y que este test valga para cualquier prefijo"

	| sentenceFinder sentencesWithPrefix|
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 't'.
	
	self assert: sentencesWithPrefix size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AF 4/27/2022 17:01:48'!
test02FinderReturnsAllSentencesWithPrefix
	| sentenceFinder sentencesWithPrefix |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: 'Winter is cold'.
	sentenceFinder addSentence: 'summer is coming'.
	sentenceFinder addSentence: 'Winning is everything'.
	sentenceFinder addSentence: 'The winds of Winter'.
	sentenceFinder addSentence: 'Winter is here'.
	sentenceFinder addSentence: 'Winter is cold'.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'Win'.
	
	self assert: sentencesWithPrefix size = 4.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AF 4/27/2022 17:00:16'!
test03NoneSentencesWithPrefixReturnsEmpty
	| sentenceFinder sentencesWithPrefix |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: 'winter is coming'.
	sentenceFinder addSentence: 'Winning is everything'.
	sentenceFinder addSentence: 'The winds of Winter'.
	sentenceFinder addSentence: 'Winter is here'.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'hola'.
	
	self assert: sentencesWithPrefix size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AF 4/27/2022 17:02:29'!
test04FinderIsCaseSensitive
	| sentenceFinder sentencesWithPrefix |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: 'winter is coming'.
	sentenceFinder addSentence: 'Winter is coming'.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'Win'.
	
	self assert: sentencesWithPrefix size = 1.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AF 4/27/2022 17:04:04'!
test05FinderSearchesPrefix
	| sentenceFinder sentencesWithPrefix |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: 'Coming is Winter'.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'Win'.
	
	self assert: sentencesWithPrefix size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AF 4/27/2022 17:08:13'!
test06FinderDoesntModifyStack
	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: 'Coming is Winter'.
	sentenceFinder addSentence: 'Winter'.
	
	sentenceFinder findSentencesWithPrefix: 'Win'.
	
	self assert: sentenceFinder showStack elements size = 2.! !


!classDefinition: #CollectionState category: 'Stack-Exercise'!
Object subclass: #CollectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #EmptyCollectionState category: 'Stack-Exercise'!
CollectionState subclass: #EmptyCollectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyCollectionState methodsFor: 'as yet unclassified' stamp: 'ldmaf 4/25/2022 21:27:23'!
top: aCollection onError: aBlock
	^(aBlock value).! !


!classDefinition: #FilledCollectionState category: 'Stack-Exercise'!
CollectionState subclass: #FilledCollectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FilledCollectionState methodsFor: 'as yet unclassified' stamp: 'ldmaf 4/25/2022 21:27:07'!
top: aCollection onError: aBlock
	^aCollection first.! !


!classDefinition: #Node category: 'Stack-Exercise'!
Object subclass: #Node
	instanceVariableNames: 'previous next value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #FilledNode category: 'Stack-Exercise'!
Node subclass: #FilledNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:48:01'!
next
	^next.! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:48:09'!
previous
	^previous.! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:04:31'!
safeValue: aBlock
	^value.! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:47:13'!
setNext: nextNode
	next  := nextNode. ! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:47:24'!
setPrevious: previousNode
	previous := previousNode. ! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:55:06'!
setValue: newValue
	value := newValue.! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:51:36'!
value
	^value.! !


!classDefinition: #NilNode category: 'Stack-Exercise'!
Node subclass: #NilNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NilNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:43:44'!
next
	^next ! !

!NilNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:43:00'!
previous
	^self error: 'Nil no tiene anterior!!'! !

!NilNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:04:54'!
safeValue: aBlock
	^aBlock value.! !

!NilNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:44:24'!
setNext: nextNode
	next  := nextNode. ! !

!NilNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:47:43'!
setPrevious: previousNode
	^self error: 'No se puede'! !

!NilNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:51:53'!
value
	^self error: 'no te puedo dar value pibe'! !


!classDefinition: #NodeList category: 'Stack-Exercise'!
Object subclass: #NodeList
	instanceVariableNames: 'current size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NodeList methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:10:42'!
addNode: aValue
	| newNode |
	newNode := FilledNode new setValue: aValue.
	newNode setPrevious: current.
	current setNext: newNode.
	current := newNode.
	size := size + 1.! !

!NodeList methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:51:21'!
head
	^current value.! !

!NodeList methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:11:07'!
isEmpty
	^size = 0.! !

!NodeList methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:10:53'!
removeNode
	current setNext: nil.
	current := current previous.
	size := size - 1.! !

!NodeList methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:04:13'!
safeHead: aBlock
	^current safeValue: aBlock.! !

!NodeList methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:10:31'!
size
	^size.! !


!NodeList methodsFor: 'init' stamp: 'LDM 4/26/2022 23:10:58'!
initialize
	current := NilNode new.
	size := 0.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'ldmaf 4/25/2022 20:11:25'!
elements
	^elements.! !

!OOStack methodsFor: 'operations' stamp: 'ldmaf 4/25/2022 20:16:33'!
isEmpty
	^ elements isEmpty.! !

!OOStack methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:09:41'!
pop
	|top|
	top := self top.
	elements removeNode.
	^top.! !

!OOStack methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:07:58'!
push: anElement
	elements addNode: anElement.! !

!OOStack methodsFor: 'operations' stamp: 'ldmaf 4/25/2022 20:33:42'!
size
	^elements size.! !

!OOStack methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:09:04'!
top
	^elements safeHead: [^self error: OOStack stackEmptyErrorDescription].
	! !


!OOStack methodsFor: 'init' stamp: 'LDM 4/26/2022 23:07:14'!
initialize
	elements := NodeList new.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'init' stamp: 'LDM 4/26/2022 23:32:03'!
initialize
	sentences := OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:32:25'!
addSentence: aSentence
	sentences push: aSentence.! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:45:20'!
findSentencesWithPrefix: aPrefix
	|sentencesWithDesiredPrefix xxx aux|
	sentencesWithDesiredPrefix := OrderedCollection new.
	xxx := OrderedCollection new.
	[sentences isEmpty not] whileTrue: [
			aux := sentences pop.
			((aux findString: aPrefix) = 1) ifTrue: [
					sentencesWithDesiredPrefix add: aux.
				].
			xxx add: aux.
		].
	xxx reverse do: [:aSentence | 
			sentences push: aSentence.
		].
	^sentencesWithDesiredPrefix. 
	
! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'AF 4/27/2022 16:09:44'!
showStack
	^sentences! !
