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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 10:18:48'!
test12PortfolioCantAddAlreadyAddedAccount

	|portfolio account|
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	portfolio add: account.
	self 
		should: [ portfolio add: account ] 
		raise: Error
		withExceptionDo: [ :error | 
				self assert: error messageText equals: Portfolio cannotAddAlreadyAddedAccount.
			].
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LDM 5/18/2022 10:27:22'!
test13PortfolioCantAddPortfolioWithAccountAlreadyInCurrentPortfolio

	|portfolio account extraPortfolio|
	
	portfolio _ Portfolio new.
	extraPortfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	portfolio add: account.
	extraPortfolio add: account.
	self 
		should: [ portfolio add: extraPortfolio. ] 
		raise: Error
		withExceptionDo: [ :error | 
				self assert: error messageText equals: Portfolio cannotAddAlreadyAddedAccountInPortfolio.
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


!Deposit methodsFor: 'as yet unclassified' stamp: 'LDM 5/18/2022 09:00:26'!
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


!Withdraw methodsFor: 'as yet unclassified' stamp: 'LDM 5/18/2022 09:01:00'!
applyTo: anAmount
	^ anAmount - value. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'operations' stamp: 'LDM 5/18/2022 11:00:52'!
add: anAsset
	(anAsset isKindOf: Portfolio) ifTrue: [
			(self containsAnyAccountOf: anAsset) ifTrue: [self error: Portfolio cannotAddAlreadyAddedAccountInPortfolio].
			portfolios add: anAsset.
		]
	ifFalse: [
			(accounts includes: anAsset) ifTrue: [self error: Portfolio cannotAddAlreadyAddedAccount].
			accounts add: anAsset.
		].! !

!Portfolio methodsFor: 'operations' stamp: 'LDM 5/18/2022 10:03:34'!
balance
	|balanceOfAccounts balanceOfPortfolios|
	balanceOfAccounts _ accounts sum: [:anAccount | anAccount balance ] ifEmpty: [0].
	balanceOfPortfolios _ portfolios sum: [:aPortfolio | aPortfolio balance ] ifEmpty: [0].
	^balanceOfAccounts + balanceOfPortfolios.! !

!Portfolio methodsFor: 'operations' stamp: 'LDM 5/18/2022 10:58:38'!
containsAnyAccountOf: aPortfolio	
	|otherPortfolioAccounts|
	otherPortfolioAccounts _ aPortfolio flattenAccounts.
	self flattenAccounts do: [:anAccount | 
			(otherPortfolioAccounts includes: anAccount) ifTrue: [^true].
		].
	^false.! !

!Portfolio methodsFor: 'operations' stamp: 'LDM 5/18/2022 10:51:02'!
flattenAccounts	
	|flattenAccounts|
	flattenAccounts _ accounts.
	portfolios do: [:aPortfolio | 
			flattenAccounts _ flattenAccounts, (aPortfolio flattenAccounts)
		].
	^flattenAccounts.! !

!Portfolio methodsFor: 'operations' stamp: 'LDM 5/18/2022 11:22:32'!
hasRegistered: aTransaction
	^self flattenAccounts anySatisfy: [:anAccount | anAccount transactions includes: aTransaction].! !

!Portfolio methodsFor: 'operations' stamp: 'LDM 5/18/2022 11:40:32'!
transactions
	|flattenTransactions|
	flattenTransactions _ Set new.
	self flattenAccounts do: [:anAccount | flattenTransactions addAll: (anAccount transactions)].
	^flattenTransactions.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'LDM 5/18/2022 09:58:44'!
initialize
	accounts _ OrderedCollection new.
	portfolios _ OrderedCollection new.! !

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
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

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
