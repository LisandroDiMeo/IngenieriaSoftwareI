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
	instanceVariableNames: 'winterIsCold summerIsComing winningIsEverything theWindsOfWinter winterIsHere winterIsVeryCold winterIsColdLowerCase win winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LDM 4/27/2022 22:33:53'!
test01SentenceFinderWithoutSentencesShouldReturnEmptyListOnFind

	| sentenceFinder sentencesWithPrefix|
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'A'.
	
	self assert: sentencesWithPrefix size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LDM 4/27/2022 22:42:34'!
test02SentenceFinderReturnsAllSentencesWithGivenPrefix
	| sentenceFinder sentencesWithPrefix expectedSentences |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: winterIsCold.
	sentenceFinder addSentence: summerIsComing.
	sentenceFinder addSentence: winningIsEverything.
	sentenceFinder addSentence: theWindsOfWinter.
	sentenceFinder addSentence: winterIsHere.
	sentenceFinder addSentence: winterIsVeryCold.
	
	expectedSentences := OrderedCollection new.
	expectedSentences addAll: 	{winterIsVeryCold. winterIsHere.winningIsEverything.winterIsCold. }.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'Win'.
	
	self assert: sentencesWithPrefix = expectedSentences.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LDM 4/27/2022 22:46:02'!
test03SentenceFinderReturnsEmptyIfNoneHasTheGivenPrefix
	| sentenceFinder sentencesWithPrefix |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: ''.
	sentenceFinder addSentence: 'Winning is everything'.
	sentenceFinder addSentence: 'The winds of Winter'.
	sentenceFinder addSentence: 'Winter is here'.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'hola'.
	
	self assert: sentencesWithPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LDM 4/27/2022 22:53:20'!
test04FinderIsCaseSensitive
	| sentenceFinder sentencesWithPrefix expectedSentences |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: winterIsColdLowerCase.
	sentenceFinder addSentence: winterIsCold.
	
	expectedSentences := OrderedCollection new.
	expectedSentences add: winterIsCold.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'Win'.
	
	self assert: sentencesWithPrefix = expectedSentences.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LDM 4/27/2022 22:55:46'!
test05SentenceFinderOnlySearchesGivenPrefixOnSentences
	| sentenceFinder sentencesWithPrefix |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: summerIsComing.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'Com'.
	
	self assert: sentencesWithPrefix size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LDM 4/27/2022 23:16:44'!
test06SentenceFinderDoesntModifyPreviouslyAddedSentences
	| sentenceFinder sentencesBeforeFindWithPrefix |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: winterIsCold.
	sentenceFinder addSentence: winterIsVeryCold.
	sentenceFinder addSentence: summerIsComing.
	
	sentencesBeforeFindWithPrefix := sentenceFinder sentences.
	
	sentenceFinder findSentencesWithPrefix: 'Win'.
	
	self assert: (sentenceFinder sentences = sentencesBeforeFindWithPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AF 4/28/2022 14:58:07'!
test07SentenceFinderShouldReturnEmptyIfSentencesAreShorterThanPrefix
	| sentenceFinder sentencesWithPrefix |
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder addSentence: win.
	sentenceFinder addSentence: winner.
	
	sentencesWithPrefix := sentenceFinder findSentencesWithPrefix: 'winners'.
	
	self assert: sentencesWithPrefix size = 0.! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'AF 4/28/2022 14:57:02'!
setUp
	winterIsCold :=  'Winter is cold'.
	summerIsComing :=  'summer is Coming'.
	winningIsEverything :=  'Winning is everything'.
	theWindsOfWinter := 'The winds of Winter'.
	winterIsHere := 'Winter is here'.
	winterIsVeryCold := 'Winter is very cold'.
	winterIsColdLowerCase  := 'winter is cold'.
	win := 'win'.
	winner := 'winner'! !


!classDefinition: #Node category: 'Stack-Exercise'!
Object subclass: #Node
	instanceVariableNames: 'previous next value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Node methodsFor: 'private' stamp: 'LDM 4/27/2022 22:21:02'!
value
	^self subclassResponsibility ! !


!Node methodsFor: 'setters' stamp: 'LDM 4/27/2022 22:20:50'!
setNext: nextNode
	^self subclassResponsibility ! !

!Node methodsFor: 'setters' stamp: 'LDM 4/27/2022 22:20:56'!
setPrevious: previousNode
	^self subclassResponsibility ! !


!Node methodsFor: 'operations' stamp: 'LDM 4/27/2022 23:03:00'!
isNil
	^self subclassResponsibility ! !

!Node methodsFor: 'operations' stamp: 'LDM 4/27/2022 22:20:33'!
next
	^self subclassResponsibility ! !

!Node methodsFor: 'operations' stamp: 'LDM 4/27/2022 22:20:39'!
previous
	^self subclassResponsibility ! !

!Node methodsFor: 'operations' stamp: 'LDM 4/27/2022 22:20:44'!
safeValue: aBlock
	^self subclassResponsibility ! !


!classDefinition: #FilledNode category: 'Stack-Exercise'!
Node subclass: #FilledNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/27/2022 23:02:52'!
isNil
	^false.! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:48:01'!
next
	^next.! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:48:09'!
previous
	^previous.! !

!FilledNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:04:31'!
safeValue: aBlock
	^value.! !


!FilledNode methodsFor: 'private' stamp: 'LDM 4/26/2022 22:51:36'!
value
	^value.! !


!FilledNode methodsFor: 'setters' stamp: 'LDM 4/26/2022 22:47:13'!
setNext: nextNode
	next  := nextNode. ! !

!FilledNode methodsFor: 'setters' stamp: 'LDM 4/26/2022 22:47:24'!
setPrevious: previousNode
	previous := previousNode. ! !

!FilledNode methodsFor: 'setters' stamp: 'LDM 4/26/2022 22:55:06'!
setValue: newValue
	value := newValue.! !


!classDefinition: #NilNode category: 'Stack-Exercise'!
Node subclass: #NilNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NilNode methodsFor: 'operations' stamp: 'LDM 4/27/2022 23:02:43'!
isNil
	^true.! !

!NilNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 22:43:44'!
next
	^next ! !

!NilNode methodsFor: 'operations' stamp: 'LDM 4/27/2022 23:41:27'!
previous
	^self error: 'Nil node has no previous!!'! !

!NilNode methodsFor: 'operations' stamp: 'LDM 4/26/2022 23:04:54'!
safeValue: aBlock
	^aBlock value.! !


!NilNode methodsFor: 'private' stamp: 'LDM 4/27/2022 23:41:05'!
value
	^self error: 'Nil node has no value!!'! !


!NilNode methodsFor: 'setters' stamp: 'LDM 4/26/2022 22:44:24'!
setNext: nextNode
	next  := nextNode. ! !

!NilNode methodsFor: 'setters' stamp: 'LDM 4/27/2022 23:42:24'!
setPrevious: previousNode
	^self error: 'Nil node has no previous. Therefore, cannot set a previous node!!'! !


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

!NodeList methodsFor: 'operations' stamp: 'LDM 4/27/2022 23:07:28'!
current
	^current.! !

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

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'LDM 4/27/2022 23:33:58'!
findSentencesWithPrefix: aPrefix
	|sentencesWithDesiredPrefix sentencesCopy poppedSentence|
	sentencesWithDesiredPrefix := OrderedCollection new.
	sentencesCopy := OrderedCollection new.
	[sentences isEmpty not] whileTrue: [
			poppedSentence := sentences pop.
			(self sentence: poppedSentence hasPrefix: aPrefix) ifTrue: [
					sentencesWithDesiredPrefix add: poppedSentence.
				].
			sentencesCopy add: poppedSentence.
		].
	sentencesCopy reverse do: [:aSentence | 
			sentences push: aSentence.
		].
	^sentencesWithDesiredPrefix. 
	
! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'LDM 4/27/2022 23:33:28'!
sentence: aSentence hasPrefix: aPrefix
	^(aSentence findString: aPrefix) = 1.
! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'LDM 4/27/2022 23:13:15'!
sentences
	| sentencesOfFinder node |
	"Esta es un metodo auxiliar para testear que el set de oraciones no se ve alterado despues de usar findSentencesWithPrefix:"
	sentencesOfFinder := OrderedCollection new.
	node := sentences elements current .
	[node isNil not] whileTrue: [
			sentencesOfFinder add: node value.
			node := node previous.
		].
	^sentencesOfFinder.! !
