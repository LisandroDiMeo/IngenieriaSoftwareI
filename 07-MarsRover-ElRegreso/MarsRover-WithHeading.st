!classDefinition: #MarsRoverCurrentPositionWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverCurrentPositionWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverCurrentPositionWindowTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:37:52'!
test01WindowLogsNothingWhenNoCommandsAreSent
	| marsRover marsRoverPositionWindow |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	marsRoverPositionWindow := MarsRoverCurrentPositionWindow followPositionChangesOn: marsRover.
	
	marsRover process: ''.
	self assert: '' equals: marsRoverPositionWindow readWindowContent.! !

!MarsRoverCurrentPositionWindowTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:38:08'!
test02WindowLogsPositionWhenForwardCommandIsSent
	| marsRover marsRoverPositionWindow |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	marsRoverPositionWindow := MarsRoverCurrentPositionWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert: marsRoverPositionWindow readWindowContent equals: 'Posicion: 1@2'.! !

!MarsRoverCurrentPositionWindowTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:38:26'!
test03WindowLogsPositionWhenBackwardCommandIsSent
	| marsRover marsRoverPositionWindow |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	marsRoverPositionWindow := MarsRoverCurrentPositionWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'b'.
	self assert: marsRoverPositionWindow readWindowContent equals: 'Posicion: 1@0'.! !

!MarsRoverCurrentPositionWindowTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:39:10'!
test04WindowLogsOnlyCurrentChangeWhenMultipleCommandsAreSentStepByStep
	| marsRover marsRoverPositionWindow |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	marsRoverPositionWindow := MarsRoverCurrentPositionWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert: marsRoverPositionWindow readWindowContent equals: 'Posicion: 1@2'.
	marsRover process: 'b'.
	self assert: marsRoverPositionWindow readWindowContent equals: 'Posicion: 1@1'.
	marsRover process: 'f'.
	self assert: marsRoverPositionWindow readWindowContent equals: 'Posicion: 1@2'.! !

!MarsRoverCurrentPositionWindowTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:39:42'!
test05WindowLogsHeadingWhenRightRotateCommandIsSent
	| marsRover marsRoverPositionWindow |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	marsRoverPositionWindow := MarsRoverCurrentPositionWindow followHeadingChangesOn: marsRover.
	
	marsRover process: 'r'.
	self assert: 'Apuntando al Este' equals: marsRoverPositionWindow readWindowContent.! !

!MarsRoverCurrentPositionWindowTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:39:58'!
test06WindowLogsHeadingWhenLeftRotateCommandIsSent
	| marsRover marsRoverPositionWindow |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	marsRoverPositionWindow := MarsRoverCurrentPositionWindow followHeadingChangesOn: marsRover.
	
	marsRover process: 'l'.
	self assert: 'Apuntando al Oeste' equals: marsRoverPositionWindow readWindowContent.! !

!MarsRoverCurrentPositionWindowTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:47:06'!
test07WindowLogsHeadingAndPositionWhenMultipleCommandsAreSentStepByStep
	| marsRover marsRoverPositionWindow |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	marsRoverPositionWindow := MarsRoverCurrentPositionWindow followHeadingChangesOn: marsRover.
	marsRoverPositionWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert: 'Posicion: 1@2' equals: marsRoverPositionWindow readWindowContent.
	marsRover process: 'r'.
	self assert: 'Posicion: 1@2 Apuntando al Este' equals: marsRoverPositionWindow readWindowContent.
	marsRover process: 'f'.
	self assert: 'Posicion: 2@2 Apuntando al Este' equals: marsRoverPositionWindow readWindowContent.! !


!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:05:32'!
test01LoggerLogsNothingWhenNoCommandsWhereSentToMarsRover

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: logger readStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:09:00'!
test02LoggerLogsOnlyOneLineWhenForwardCommandIsSent

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:10:36'!
test03LoggerLogsOnlyOneLineWhenBackwardCommandIsSent

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'b'.
	
	logStream := logger readStream.
	self assert: '1@0' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:11:10'!
test04LoggerLogsOnlyTwoLinesWhenForwardAndBackwardCommandsAreSent

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'fb'.
	
	logStream := logger readStream.
	self assert: '2@1' equals: logStream nextLine.
	self assert: '1@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:12:07'!
test05LoggerLogsOnlyOneLineWhenRightRotateCommandIsSent

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'East' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:22:56'!
test06LoggerLogsOnlyOneLineWhenLeftRotateCommandIsSent

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'l'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:37:32'!
test07LoggerLogsOnlyTwoLinesWhenTwoLeftRotateCommandAreSent

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'll'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'South' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 18:36:46'!
test08LoggerLogsOnlyTwoLinesWhenLeftAndRightRotateCommandAreSent

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'lr'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'North' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 19:30:54'!
test09LoggerLogsChangesOfBothRotationsAndPositionsCommands

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	logger followPositionChangesOn: marsRover.
	
	marsRover process: 'frf'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: 'East' equals: logStream nextLine.
	self assert: '2@2' equals: logStream nextLine.
	self assert: logStream atEnd.

! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverVisitorTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverVisitorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverVisitorTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:01:03'!
test01BothVisitorsLogCorrectlyWhenSingleCommandIsExecuted
	| marsRover logger window logStream |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger followPositionChangesOn: marsRover.
	window _ MarsRoverCurrentPositionWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
	self assert: 'Posicion: 1@2' equals: window readWindowContent.! !

!MarsRoverVisitorTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:00:17'!
test02BothVisitorsLogCorrectlyWhenMultipleCommandsAreExecuted
	| marsRover logger window logStream |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger followPositionChangesOn: marsRover.
	logger followHeadingChangesOn: marsRover.
	window _ MarsRoverCurrentPositionWindow followPositionChangesOn: marsRover.
	window followHeadingChangesOn: marsRover.
	
	marsRover process: 'frf'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: 'East' equals: logStream nextLine.
	self assert: '2@2' equals: logStream nextLine.
	self assert: logStream atEnd.
	self assert: 'Posicion: 2@2 Apuntando al Este' equals: window readWindowContent.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head proxy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'ldmaf 6/1/2022 21:32:21'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	proxy _ MarsRoverProxy for: self. ! !


!MarsRover methodsFor: 'heading' stamp: 'ldmaf 6/1/2022 21:27:44'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	proxy notifyHeadingTo: head.! !

!MarsRover methodsFor: 'heading' stamp: 'ldmaf 6/1/2022 21:27:39'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	proxy notifyHeadingTo: head.! !

!MarsRover methodsFor: 'heading' stamp: 'ldmaf 6/1/2022 21:27:49'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	proxy notifyHeadingTo: head.
! !

!MarsRover methodsFor: 'heading' stamp: 'ldmaf 6/1/2022 21:27:52'!
headWest
	
	head := MarsRoverHeadingWest for: self. 
	proxy notifyHeadingTo: head.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'ldmaf 6/1/2022 21:28:01'!
addToPositionAndLogNewPosition: newPosition

	position := position + newPosition.
	proxy notifyMoveTo: position.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveEast
	
	self addToPositionAndLogNewPosition: 1@0.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveNorth
	
	self addToPositionAndLogNewPosition: 0@1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveSouth
	
	self addToPositionAndLogNewPosition: 0@-1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveWest
	
	self addToPositionAndLogNewPosition: -1@0! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:31:15'!
addVisitor: aVisitor
	proxy addVisitor: aVisitor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:29:47'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingEast: self! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'ldmaf 5/30/2022 21:35:04'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingNorth: self! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'ldmaf 5/30/2022 21:35:46'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingSouth: self! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'ldmaf 5/30/2022 21:30:00'!
accept: aVisitor 
	^aVisitor visitMarsRoverHeadingWest: self! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverProxy category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverProxy
	instanceVariableNames: 'visitors marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverProxy methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:31:32'!
addVisitor: aVisitor
	visitors add: aVisitor.! !

!MarsRoverProxy methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:18:54'!
initializeWith: aMarsRover
	marsRover _ aMarsRover.
	visitors _ OrderedCollection new.! !

!MarsRoverProxy methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:29:55'!
notifyHeadingTo: aMarsRoverHeading
	visitors do: [:aVisitor | aVisitor headingChangedTo: aMarsRoverHeading].! !

!MarsRoverProxy methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:29:35'!
notifyMoveTo: aPosition
	visitors do: [:aVisitor | aVisitor positionChangedTo: aPosition].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverProxy class' category: 'MarsRover-WithHeading'!
MarsRoverProxy class
	instanceVariableNames: ''!

!MarsRoverProxy class methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:18:13'!
for: aMarsRover
	^self new initializeWith: aMarsRover.! !


!classDefinition: #MarsRoverVisitor category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverVisitor
	instanceVariableNames: 'willVisitHead willVisitPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverVisitor methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:50:22'!
followHeadingChangesOn: aMarsRover 
	willVisitPosition ifFalse: [
			aMarsRover addVisitor: self
		].
	willVisitHead _ true.! !

!MarsRoverVisitor methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:50:31'!
followPositionChangesOn: aMarsRover 
	willVisitHead ifFalse: [
			aMarsRover addVisitor: self
		].
	willVisitPosition _ true.
	! !

!MarsRoverVisitor methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:51:45'!
headingChangedTo: aMarsRoverHeading
	self subclassResponsibility.! !

!MarsRoverVisitor methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:51:30'!
positionChangedTo: aPosition
	self subclassResponsibility.! !

!MarsRoverVisitor methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:52:06'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast
	self subclassResponsibility.! !

!MarsRoverVisitor methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:52:21'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth
	self subclassResponsibility.! !

!MarsRoverVisitor methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:52:31'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth
	self subclassResponsibility.! !

!MarsRoverVisitor methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 21:52:11'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest
	self subclassResponsibility.! !


!classDefinition: #MarsRoverCurrentPositionWindow category: 'MarsRover-WithHeading'!
MarsRoverVisitor subclass: #MarsRoverCurrentPositionWindow
	instanceVariableNames: 'log headingField positionField'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverCurrentPositionWindow methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:37:37'!
headingChangedTo: aMarsRoverHeading
	willVisitHead ifTrue: [
			headingField ifNil: [headingField _ '']. 
			aMarsRoverHeading accept: self.	
		].
	! !

!MarsRoverCurrentPositionWindow methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:38:02'!
initialize
	log _ ''.
	willVisitPosition _ false.
	willVisitHead _ false.! !

!MarsRoverCurrentPositionWindow methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:37:11'!
positionChangedTo: aPosition
	willVisitPosition ifTrue: [
			positionField ifNil: [positionField _ ''].
			positionField _ aPosition asString.
		].
! !

!MarsRoverCurrentPositionWindow methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:05:19'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast
	headingField _ 'Este'.! !

!MarsRoverCurrentPositionWindow methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:05:40'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth
	headingField _ 'Norte'.! !

!MarsRoverCurrentPositionWindow methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:05:51'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth
	headingField _ 'Sur'.! !

!MarsRoverCurrentPositionWindow methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:05:30'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest
	headingField _ 'Oeste'.! !


!MarsRoverCurrentPositionWindow methodsFor: 'content read' stamp: 'ldmaf 6/1/2022 19:35:04'!
readWindowContent
	|content|
	content _ ''.
	positionField ifNotNil: [content _ content , 'Posicion: ', positionField].
	headingField ifNotNil: [
			(content isEmpty) ifTrue: [content _ 'Apuntando al ', headingField] ifFalse: [content _ content, ' Apuntando al ', headingField]. 
		].
	^content! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCurrentPositionWindow class' category: 'MarsRover-WithHeading'!
MarsRoverCurrentPositionWindow class
	instanceVariableNames: 'headingField positionField'!

!MarsRoverCurrentPositionWindow class methodsFor: 'instance creation' stamp: 'ldmaf 6/1/2022 19:18:02'!
followHeadingChangesOn: aMarsRover 
	^self new followHeadingChangesOn: aMarsRover ! !

!MarsRoverCurrentPositionWindow class methodsFor: 'instance creation' stamp: 'ldmaf 6/1/2022 18:56:26'!
followPositionChangesOn: aMarsRover 
	^self new followPositionChangesOn: aMarsRover ! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverVisitor subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:51:22'!
headingChangedTo: aMarsRoverHeading
	willVisitHead ifTrue: [aMarsRoverHeading accept: self].
	! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:45:53'!
initialize

	log  := WriteStream on: ''.
	willVisitPosition _ false.
	willVisitHead _ false.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 20:43:10'!
positionChangedTo: aPosition
	willVisitPosition ifTrue: [log print: aPosition; newLine].! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:23:26'!
readStream
	
	^ReadStream on: log contents ! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:46:36'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	
	log nextPutAll: 'East'; newLine! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/1/2022 18:37:53'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth
	
	log nextPutAll: 'North'; newLine! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:36:39'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth
	
	log nextPutAll: 'South'; newLine! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'ldmaf 5/30/2022 21:30:17'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest
	
	log nextPutAll: 'West'; newLine! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:42:45'!
followHeadingChangesOn: aMarsRover 
	
	^self new followHeadingChangesOn: aMarsRover ! !

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:16:11'!
followPositionChangesOn: aMarsRover 
	
	^self new followPositionChangesOn: aMarsRover ! !
