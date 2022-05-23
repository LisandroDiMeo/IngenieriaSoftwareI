!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:18:39'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 09:08:06'!
test08AnEmptyPortfolioHasZeroAsBalance

	|portfolio|
	
	portfolio _ Portfolio new.

	self assert: (portfolio balance = 0).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 09:12:02'!
test09AnEmptyPorfolioWithAnEmptyAccountHasZeroAsBalance

	|portfolio account|
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.

	self assert: (portfolio balance = 0).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 09:15:05'!
test10PortfolioWithNonEmptyAccoutHasTheSameBalanceAsTheAccount

	|portfolio account|
	
	portfolio _ Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	portfolio add: account.

	self assert: (portfolio balance = account balance).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 10:02:15'!
test11PortfolioWithNonEmptyAccountAndNonEmptyPortfolioHasTheSameBalanceAsTheSumOfThem

	|portfolio account extraPortfolio extraAccount|
	
	portfolio _ Portfolio new.
	account := ReceptiveAccount new.
	extraPortfolio  _ Portfolio new.
	extraAccount := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	portfolio add: account.
	Deposit register: 420 on: extraAccount.
	extraPortfolio add: extraAccount.
	portfolio add: extraPortfolio.

	self assert: (portfolio balance = (extraPortfolio balance + account balance)).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ldm 5/23/2022 15:38:02'!
test12PortfolioCantAddAlreadyAddedAccount

	|portfolio account|
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	portfolio add: account.
	self 
		should: [ portfolio add: account ] 
		raise: Error
		withExceptionDo: [ :error | 
				self assert: error messageText equals: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph.
			].
		
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 11:20:14'!
test14PortfolioAnswersTrueToHasRegisteredWhenTransactionWasRegistered
	
	|portfolio account transaction|
	
	portfolio _ Portfolio new.
	account := ReceptiveAccount new.
	transaction _ Deposit register: 100 on: account.
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: transaction).
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 11:24:25'!
test15PortfolioAnswersFalseToHasRegisteredWhenTransactionWasNotRegistered
	
	|portfolio transaction accountOutsidePortfolio|
	
	portfolio _ Portfolio new.
	accountOutsidePortfolio := ReceptiveAccount new.
	transaction _ Deposit register: 100 on: accountOutsidePortfolio.
	
	self assert: ((portfolio hasRegistered: transaction) not).
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 11:40:39'!
test16PortfolioReturnAllOfItsTransactions
	
	| transaction transaction1 transaction2 transaction3 transaction4 account account2 portfolio extraPortfolio allTransactions| 
	
	portfolio := Portfolio new.
	extraPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	transaction := Deposit register: 50 on: account.
	transaction1 := Deposit register: 150 on: account.
	transaction2 := Withdraw register: 50 on: account.
	transaction3 := Deposit register: 30 on: account2.
	transaction4 := Deposit register: 10 on: account2.

	extraPortfolio add: account.
	portfolio add: account2.
	portfolio add: extraPortfolio.
	
	allTransactions _ (Set with: transaction with: transaction1 with: transaction2 with: transaction3 with: transaction4).

	self assert: (portfolio transactions = allTransactions).
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ldm 5/23/2022 15:43:02'!
test17AddingAnAccountToAPortfolioThatExistsInAnotherPortfolioAndHaveThatAccountShouldFail
	
	| account portfolio extraPortfolio | 
	
	portfolio := Portfolio new.
	extraPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio add: account.
	extraPortfolio add: portfolio.
	
	self 
		should: [ extraPortfolio add: account. ] 
		raise: Error
		withExceptionDo: [ :error | 
				self assert: error messageText equals: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph.
			].
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ldm 5/23/2022 01:40:19'!
test18AddingAccountIntoPortfolioInsideAnotherPortfolioWithThatAccountShouldFail
	
	| account portfolio extraPortfolio | 
	
	portfolio := Portfolio new.
	extraPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio add: account.
	portfolio add: extraPortfolio.
	
	self 
		should: [ extraPortfolio add: account. ] 
		raise: Error
		withExceptionDo: [ :error | 
				self assert: true.
			].
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ldm 5/23/2022 03:46:12'!
test19AddingAPortfolioToInmediateParentPortfolioThrowsAnError
	
	| portfolio extraPortfolio | 
	
	portfolio := Portfolio new.
	extraPortfolio := Portfolio new.
	
	portfolio add: extraPortfolio.
	
	self 
		should: [ extraPortfolio add: portfolio. ] 
		raise: Error
		withExceptionDo: [ :error |
				self assert: true.
			].
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ldm 5/23/2022 15:52:22'!
test20AddingAPortfolioThatAlreadyExistsInPortfolioHirearchyThrowsError
	
	| portfolioA portfolioB portfolioC portfolioD portfolioE  | 
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	portfolioC := Portfolio new.
	portfolioD := Portfolio new.
	portfolioE := Portfolio new.
	
	portfolioA add: portfolioB.
	portfolioA add: portfolioE.
	portfolioB add: portfolioC.
	portfolioB add: portfolioD.
	
	self 
		should: [ portfolioC add: portfolioE. ] 
		raise: Error
		withExceptionDo: [ :error |
				self assert: error messageText equals: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph.
			].
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ldm 5/23/2022 15:42:38'!
xxxtest13PortfolioCantAddPortfolioWithAccountAlreadyInCurrentPortfolio

	|portfolio account extraPortfolio|

	"Este test esta en observacion, ya que a veces da positivo y a veces no."
	
	portfolio _ Portfolio new.
	extraPortfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	portfolio add: account.
	extraPortfolio add: account.
	self 
		should: [ portfolio add: extraPortfolio. ] 
		raise: Error
		withExceptionDo: [ :error | 
				self assert: true.
			].
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'operations' stamp: 'LDM 5/18/2022 09:00:26'!
applyTo: anAmount
	^ value + anAmount. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'operations' stamp: 'LDM 5/18/2022 09:01:00'!
applyTo: anAmount
	^ anAmount - value. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AssetsGraph category: 'Portfolio-Ejercicio'!
Object subclass: #AssetsGraph
	instanceVariableNames: 'nodes linkedGraphs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 00:59:28'!
addFirstNode: aNode
	nodes add: aNode.! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 00:29:09'!
addLinkTo: aGraph
	linkedGraphs add: aGraph.! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 03:44:29'!
checkLinkedGraphsContains: aNode
	^linkedGraphs anySatisfy: [:aGraph |		aGraph nodes includes: aNode].! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 15:43:39'!
createVertexFrom: aNode to: anotherNode
	|node|
	(aNode equals: anotherNode) ifTrue: [self error: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph.]. 
	(nodes includes: aNode) not ifTrue: [nodes add: aNode].
	(nodes includes: anotherNode) not ifTrue: [	nodes add: anotherNode] ifFalse: [self error: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph.].
	
	node _ (nodes select: [:aGraphNode | aGraphNode equals: aNode]) first.
	node createLinkTo: anotherNode.
	
	(self detectCycles) ifTrue: [
			node removeLinkTo: anotherNode.
			nodes removeLast.
			self error: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph.
		].
	! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 03:21:25'!
depthFirstSearch
	|visited stack currentNode| 
	stack _ OrderedCollection new.
	visited _ Set new.
	stack add: (nodes first).
	
	[stack isEmpty not] whileTrue: [
			currentNode _ stack last.
			stack removeLast.
			(visited includes: currentNode) not ifTrue: [visited add: currentNode].
			currentNode vertices do: [:anAdjacentNode | 
					((visited includes: anAdjacentNode)) ifFalse: [ stack add: anAdjacentNode ].
				]
		].
	^visited.
	! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 03:21:41'!
detectCycles
	|visited stack currentNode cycleDetected| 
	stack _ OrderedCollection new.
	visited _ OrderedCollection new.
	stack add: (nodes first).
	cycleDetected _ false.
	
	[stack isEmpty not] whileTrue: [
			currentNode _ stack last.
			stack removeLast.
			(visited includes: currentNode) not ifTrue: [visited add: currentNode].
			currentNode vertices do: [:anAdjacentNode |
					(visited includes: anAdjacentNode) ifTrue: [ cycleDetected _ true ]
					ifFalse: [stack add: anAdjacentNode].
				]
		].
	^cycleDetected.
	! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 00:26:29'!
initialize
	nodes _ OrderedCollection new.
	linkedGraphs _ Set new.! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 04:15:20'!
isLinkedTo: aGraph
	^(linkedGraphs includes: aGraph).! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 15:53:40'!
linkGraph: aGraph fromNode: aDestinationNode to: aHostNode
	(aGraph isLinkedTo: self) ifTrue: [self error: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph].
	(self isLinkedTo: aGraph) ifTrue: [self error: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph].
	(aGraph nodes includes: aDestinationNode) not ifTrue: [self error: 'destination graph does not have origin node'].
	
	self createVertexFrom: aHostNode to: aDestinationNode.
	linkedGraphs add: aGraph.
	aGraph addLinkTo: self.
	
	nodes addAll: (aGraph nodes select: [:nodesToAdd | (nodesToAdd = aDestinationNode) not]).! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 23:31:33'!
nodes
	^nodes copy.! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 00:09:51'!
remove: aNode
	nodes remove: aNode.! !

!AssetsGraph methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 01:03:03'!
withRoot: aRoot
	nodes add: aRoot.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AssetsGraph class' category: 'Portfolio-Ejercicio'!
AssetsGraph class
	instanceVariableNames: ''!

!AssetsGraph class methodsFor: 'error' stamp: 'ldm 5/23/2022 15:39:30'!
ErrorCantAddAnAssetAlreadyInGraph
	^'Error!! Unable to add an asset that already exists in Assets Graph.'.! !


!AssetsGraph class methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 01:02:38'!
with: aRoot
	^AssetsGraph new withRoot: aRoot.! !


!classDefinition: #AssetsGraphNode category: 'Portfolio-Ejercicio'!
Object subclass: #AssetsGraphNode
	instanceVariableNames: 'value vertices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 21:17:24'!
addVertexTo: aNode
	vertices add: aNode.! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 03:20:56'!
createLinkTo: aNode
	vertices add: aNode.
	"aNode addVertexTo: self."! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 03:06:02'!
disableBackLinkFrom: aNode
	vertices remove: aNode.! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 21:46:56'!
equals: anotherNode
	^value = (anotherNode value)! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 22:05:30'!
hasLinkWith: aNode
	^vertices includes: aNode.! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 22:05:48'!
initialize
	vertices _ Set new.! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 23:14:46'!
removeLinkTo: aNode
	vertices remove: aNode.! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 21:16:05'!
value
	^value.! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 22:45:15'!
vertices
	^vertices copy.! !

!AssetsGraphNode methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 21:01:36'!
withValue: aValue
	value _ aValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AssetsGraphNode class' category: 'Portfolio-Ejercicio'!
AssetsGraphNode class
	instanceVariableNames: ''!

!AssetsGraphNode class methodsFor: 'as yet unclassified' stamp: 'ldm 5/22/2022 21:46:28'!
with: aValue
	^AssetsGraphNode new withValue: aValue.! !


!classDefinition: #BankAsset category: 'Portfolio-Ejercicio'!
Object subclass: #BankAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAsset methodsFor: 'as yet unclassified' stamp: 'LDMAF 5/19/2022 20:44:36'!
balance
	self subclassResponsibility ! !

!BankAsset methodsFor: 'as yet unclassified' stamp: 'LDMAF 5/19/2022 20:44:32'!
transactions
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAsset subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios parentPorfolios assets node'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialize' stamp: 'ldm 5/23/2022 15:32:41'!
initialize
	node _ AssetsGraphNode with: self.
	assets _ AssetsGraph with: node.! !


!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 15:51:42'!
accounts
	^ assets depthFirstSearch select: [ :aNode | ((aNode value) isAnAccount) ].! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 00:57:29'!
add: anAsset
	anAsset addTo: self.
! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 15:49:31'!
addAccount: anAccount
	|linkedGraphsDoesContainsAsset|
	linkedGraphsDoesContainsAsset _ assets checkLinkedGraphsContains: (anAccount node).
	linkedGraphsDoesContainsAsset ifFalse: [assets createVertexFrom: node to: (anAccount node)] ifTrue: [self error: AssetsGraph ErrorCantAddAnAssetAlreadyInGraph].
	! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 01:07:00'!
addPortfolio: aPortfolio
	assets linkGraph: (aPortfolio graph) fromNode: (aPortfolio root) to: node.
	! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 01:25:32'!
addTo: aPortfolio
	aPortfolio addPortfolio: self.
		
	
	! !

!Portfolio methodsFor: 'operations' stamp: 'LDMAF 5/19/2022 21:21:50'!
assets
	^assets ! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 01:30:45'!
balance 
	^(self accounts) sum: [:aNode | (aNode value) balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 01:07:23'!
graph
	^assets
	! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/22/2022 18:15:08'!
hasRegistered: aTransaction
	^self transactions includes: aTransaction.
	! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 15:51:07'!
isAnAccount
	^false. ! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 01:07:36'!
root
	^node.
	! !

!Portfolio methodsFor: 'operations' stamp: 'ldm 5/23/2022 01:39:04'!
transactions
	|setOfTransactions|
	setOfTransactions _ Set new.
	self accounts do: [:aNode | setOfTransactions addAll: (aNode value transactions) ].
	^setOfTransactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LDM 5/18/2022 10:19:39'!
cannotAddAlreadyAddedAccount
	^'A portfolio cannot add an already added account.'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LDM 5/18/2022 10:27:56'!
cannotAddAlreadyAddedAccountInPortfolio
	^'A portfolio cannot add a portfolio that has a common account.'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions node'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ldm 5/23/2022 00:54:38'!
initialize
	node _ AssetsGraphNode with: self.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'LDM 5/18/2022 08:59:56'!
balance
	| accumulatedBalance |
	accumulatedBalance _ 0.
	transactions do: [:aTransaction | 
			accumulatedBalance _ aTransaction applyTo: accumulatedBalance.
		].
	^accumulatedBalance. ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 00:57:55'!
addTo: aPortfolio
	aPortfolio addAccount: self.
! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 15:51:21'!
isAnAccount
	^true. ! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'ldm 5/23/2022 00:55:41'!
node
	^node.! !
