!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aProduct'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/2/2022 20:45:00'!
test01CartIsEmptyWhenIsCreated
	|aCart|
	
	aCart _ Cart new.
	
	self assert: (aCart isEmpty)! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/2/2022 21:21:14'!
test02CartIsNotEmptyWhenAProductIsAdded
	|aCart aBook aCatalogue|
	aCatalogue _ (OrderedCollection with: '9782253096405').
	aCart _ Cart with: aCatalogue.
	aBook _ Book with: '9782253096405'.
	aCart add: aBook.
	
	self assert: (aCart isEmpty not)! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/2/2022 21:15:15'!
test03CantAddBooksNotEditedByEditorToCart
	|aCart aBook aCatalogue|
	
	aCatalogue _ OrderedCollection new.
	aCart _ Cart with: aCatalogue.
	aBook _ Book with: '9786070776564'.
	
	self should: [aCart add: aBook] raise: Error description: 'Cannot add a book not registered in our inventory.'.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/2/2022 21:29:17'!
test04CartCanAddMultipleAmountsOfTheSameBook
	|aCart aBook aCatalogue|
	
	aCatalogue _ OrderedCollection with: '9789500708517'.
	aCart _ Cart with: aCatalogue.
	aBook _ Book with: '9789500708517'.
	aCart add: 10 of: aBook.
	
	self assert: (aCart booksQuantity = 10).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/4/2022 15:53:25'!
test05CartThrowsErrorWhenAnInvalidAmountIsRequested
	|aCart aBook aCatalogue|
	
	aCatalogue _ OrderedCollection with: '9789500708517'.
	aCart _ Cart with: aCatalogue.
	aBook _ Book with: '9789500708517'.
	
	self should: [aCart add: 0 of: aBook] raise: Error description: 'Cannot add an invalid amount of books.'.
	self should: [aCart add: -1 of: aBook] raise: Error description: 'Cannot add an invalid amount of books.'.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/4/2022 15:59:05'!
test06CartAddedBooksAreCorrect
	|aCart aBook1 aBook2 aCatalogue|
	
	aCatalogue _ OrderedCollection with: '9789500708517' with: '9781644730942'.
	aCart _ Cart with: aCatalogue.
	aBook1 _ Book with: '9789500708517'.
	aBook2 _ Book with: '9781644730942'.
	
	aCart add: aBook1.
	aCart add: 3 of: aBook2.
	self assert: (aCart doesInclude: 3 of: aBook2).
	self assert: (aCart doesInclude: 1 of: aBook1).
	self assert: (aCart booksQuantity = 4).
	
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/4/2022 16:07:40'!
test07CartCanRequestItsContents
	|aCart aBook1 aBook2 aCatalogue cartContents|
	
	aCatalogue _ OrderedCollection with: '9788499983196' with: '9786070731747'.
	aCart _ Cart with: aCatalogue.
	aBook1 _ Book with: '9788499983196'.
	aBook2 _ Book with: '9786070731747'.
	
	aCart add: aBook1.
	aCart add: 2 of: aBook2.
	cartContents _ aCart contents.
	self assert: (( cartContents occurrencesOf: aBook1 ) = 1).
	self assert: (( cartContents occurrencesOf: aBook2 ) = 2).
	self assert: (cartContents size = 3).
	
	! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialize' stamp: 'ldmaf 6/2/2022 20:49:20'!
initializeWith: anISBN 
	isbn _ anISBN.! !


!Book methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/2/2022 21:24:01'!
isbn
	^isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'ldmaf 6/2/2022 20:48:38'!
with: anISBN 
	^self new initializeWith: anISBN.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'ldmaf 6/4/2022 16:00:54'!
doesInclude: anAmount of: aBook 
	^(items occurrencesOf: aBook) = anAmount.! !

!Cart methodsFor: 'assertions' stamp: 'ldmaf 6/2/2022 20:51:11'!
isEmpty
	^items isEmpty.! !


!Cart methodsFor: 'operations' stamp: 'ldmaf 6/2/2022 21:23:46'!
add: aBook 
	(catalogue anySatisfy: [:aCatalogueBook | 
			(aCatalogueBook isbn) = (aBook isbn)
		]) ifFalse: [self error: 'Cannot add a book not registered in our inventory.'].
	items add: aBook.! !

!Cart methodsFor: 'operations' stamp: 'ldmaf 6/4/2022 15:54:18'!
add: anAmount of: aBook 
	(anAmount <= 0) ifTrue: [self error: 'Cannot add an invalid amount of books.'].
	anAmount timesRepeat: [self add: aBook].! !

!Cart methodsFor: 'operations' stamp: 'ldmaf 6/2/2022 21:32:27'!
booksQuantity
	^items size.! !

!Cart methodsFor: 'operations' stamp: 'ldmaf 6/4/2022 16:03:30'!
contents
	^items copy.! !


!Cart methodsFor: 'initialize' stamp: 'ldmaf 6/2/2022 21:11:25'!
initialize
	items _ OrderedCollection new.
	catalogue _ OrderedCollection new.! !

!Cart methodsFor: 'initialize' stamp: 'ldmaf 6/2/2022 21:20:30'!
initializeWith: aCatalogue 
	items _ OrderedCollection new.
	catalogue _ OrderedCollection new.
	aCatalogue do: [:isbn | catalogue add: (Book with: isbn)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'ldmaf 6/2/2022 21:14:30'!
with: aCatalogue
	^self new initializeWith: aCatalogue! !
