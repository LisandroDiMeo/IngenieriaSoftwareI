!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'LDM 5/15/2022 04:59:21'!
assertThat: rover afterCommand: aCommand isAt: aPoint and: aBlock

	^ self assert: (((rover processCommand: aCommand) isAt: aPoint ) and: (aBlock value))! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:29:42'!
assertThat: rover afterSingleBackwardCommandIsAt: aPoint and: aBlock

	^ self assert: (((rover processCommand: 'b') isAt: aPoint ) and: (aBlock value))! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:27:17'!
assertThat: rover afterSingleForwardCommandIsAt: aPoint and: aBlock

	^ self assert: (((rover processCommand: 'f') isAt: aPoint ) and: (aBlock value))! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:32:44'!
assertThat: rover afterSingleLeftCommandIsAt: aPoint and: aBlock

	^ self assert: (((rover processCommand: 'l') isAt: aPoint ) and: (aBlock value))! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:33:25'!
assertThat: rover afterSingleRightCommandIsAt: aPoint and: aBlock

	^ self assert: (((rover processCommand: 'r') isAt: aPoint ) and: (aBlock value))! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:09:59'!
isAtOriginAfterSingleLeftRotation: aRover
	^((aRover processCommand: 'l') isAt: (0@0)).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LDM 5/15/2022 05:00:00'!
test01RoverProcessEmptyCommandDoesntChangeItsPosition
	|rover|
	rover _ MarsRover heading: South.
	self assertThat: rover afterCommand: '' isAt: (0@0) and: [rover isHeadingToSouth]. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:32:44'!
test02RoverSingleLeftRotationFromSouthIsWest
	|rover|
	rover _ MarsRover heading: South.
	self assertThat: rover afterSingleLeftCommandIsAt: (0@0) and: [rover isHeadingToWest].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:32:44'!
test03RoverSingleLeftRotationFromWestIsNorth
	|rover|
	rover _ MarsRover heading: West.
	self assertThat: rover afterSingleLeftCommandIsAt: (0@0) and: [rover isHeadingToNorth] .! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:32:44'!
test04RoverSingleLeftRotationFromNorthIsEast
	|rover|
	rover _ MarsRover heading: North.
	self assertThat: rover afterSingleLeftCommandIsAt: (0@0) and: [rover isHeadingToEast].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:32:44'!
test05RoverSingleLeftRotationFromEastIsSouth
	|rover|
	rover _ MarsRover heading: East.
	self assertThat: rover afterSingleLeftCommandIsAt: (0@0) and: [rover isHeadingToSouth].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:33:25'!
test06RoverSingleRightRotationFromSouthIsEast
	|rover|
	rover _ MarsRover heading: South.
	self assertThat: rover afterSingleRightCommandIsAt: (0@0) and: [rover isHeadingToEast].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:33:25'!
test07RoverSingleRightRotationFromEastIsNorth
	|rover|
	rover _ MarsRover heading: East.
	self assertThat: rover afterSingleRightCommandIsAt: (0@0) and: [rover isHeadingToNorth].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:33:25'!
test08RoverSingleRightRotationFromNorthIsWest
	|rover|
	rover _ MarsRover heading: North.
	self assertThat: rover afterSingleRightCommandIsAt: (0@0) and: [rover isHeadingToWest].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:33:26'!
test09RoverSingleRightRotationFromWestIsSouth
	|rover|
	rover _ MarsRover heading: West.
	self assertThat: rover afterSingleRightCommandIsAt: (0@0) and: [rover isHeadingToSouth].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LDM 5/14/2022 18:41:39'!
test10RoverFourSingleRotationFromWestIsWest
	|rover|
	rover _ MarsRover heading: West.
	rover processCommand: 'r'.
	rover processCommand: 'r'.
	rover processCommand: 'r'.
	rover processCommand: 'r'.
	self assert: ((rover isAt: (0@0)) and: (rover isHeadingToWest) ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LDM 5/14/2022 18:42:39'!
test11RoverSingleRightRotationAndSingleLeftRotationFromWestIsWest
	|rover|
	rover _ MarsRover heading: West.
	rover processCommand: 'r'.
	rover processCommand: 'l'.
	self assert: ((rover isAt: (0@0)) and: (rover isHeadingToWest) ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:27:56'!
test12RoverSingleForwardCommandFromNorthAdvancesOneUnitNorth
	|rover|
	rover _ MarsRover heading: North.
	self assertThat: rover afterSingleForwardCommandIsAt: (0@1) and: [rover isHeadingToNorth].
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:28:21'!
test13RoverSingleForwardCommandFromSouthAdvancesOneUnitSouth
	|rover|
	rover _ MarsRover heading: South.
	self assertThat: rover afterSingleForwardCommandIsAt: (0@-1) and: [rover isHeadingToSouth].
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:28:59'!
test14RoverSingleForwardCommandFromEastAdvancesOneUnitEast
	|rover|
	rover _ MarsRover heading: East.
	self assertThat: rover afterSingleForwardCommandIsAt: (1@0) and: [rover isHeadingToEast].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:29:20'!
test15RoverSingleForwardCommandFromWestAdvancesOneUnitWest
	|rover|
	rover _ MarsRover heading: West.
	self assertThat: rover afterSingleForwardCommandIsAt: (-1@0) and: [rover isHeadingToWest].
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:30:07'!
test16RoverSingleBackwardCommandFromNorthReducesOneUnitNorth
	|rover|
	rover _ MarsRover heading: North.
	self assertThat: rover afterSingleBackwardCommandIsAt: (0@-1) and: [rover isHeadingToNorth].
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:30:29'!
test17RoverSingleBackwardCommandFromSouthReducesOneUnitSouth
	|rover|
	rover _ MarsRover heading: South.
	self assertThat: rover afterSingleBackwardCommandIsAt: (0@1) and: [rover isHeadingToSouth].
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:30:55'!
test18RoverSingleBackwardCommandFromEastReducesOneUnitEast
	|rover|
	rover _ MarsRover heading: East.
	self assertThat: rover afterSingleBackwardCommandIsAt: (-1@0) and: [rover isHeadingToEast].
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/16/2022 15:31:33'!
test19RoverSingleBackwardCommandFromWestReducesOneUnitWest
	|rover|
	rover _ MarsRover heading: West.
	self assertThat: rover afterSingleBackwardCommandIsAt: (1@0) and: [rover isHeadingToWest].
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LDM 5/15/2022 03:01:36'!
test20RoverSingleBackwardAndSingleForwardDoesNotChangeItsPosition
	|rover|
	rover _ MarsRover heading: West.
	rover processCommand: 'b'.
	rover processCommand: 'f'.
	self assert: ((rover isAt: (0@0)) and: (rover isHeadingToWest) ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LDM 5/15/2022 03:09:11'!
test21RoverSingleForwardFromNorthAndSingleForwardFromEastIs1and1Position
	|rover|
	rover _ MarsRover heading: North.
	rover processCommand: 'f'.
	rover processCommand: 'l'.
	rover processCommand: 'f'.
	self assert: ((rover isAt: (1@1)) and: (rover isHeadingToEast) ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LDM 5/15/2022 03:19:10'!
test22RoverDoubleLeftRotationCommandFromSouthIsNorth
	|rover|
	rover _ MarsRover heading: South.
	rover processCommand: 'll'.
	self assert: ((rover isAt: (0@0)) and: (rover isHeadingToNorth) ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LDM 5/15/2022 03:40:31'!
test23RoverLeftForwardRightForwardStartingAtSouthIsCoordinateMinusOneXAndMinusOneY
	|rover|
	rover _ MarsRover heading: South.
	rover processCommand: 'lfrf'.
	self assert: ((rover isAt: (-1@-1)) and: (rover isHeadingToSouth) ).! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: 'direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:02:36'!
isEast
	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:02:28'!
isNorth
	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:02:44'!
isSouth
	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:02:33'!
isWest
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: 'MarsRover'!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'instance creation' stamp: 'LDM 5/13/2022 01:43:40'!
east
	^East new.! !

!CardinalDirection class methodsFor: 'instance creation' stamp: 'LDM 5/13/2022 01:43:46'!
north
	^North new.! !

!CardinalDirection class methodsFor: 'instance creation' stamp: 'LDM 5/13/2022 01:43:51'!
south
	^South new.! !

!CardinalDirection class methodsFor: 'instance creation' stamp: 'LDM 5/13/2022 01:43:55'!
west
	^West new.! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:09'!
isEast
	^true.! !

!East methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:20'!
isNorth
	^false.! !

!East methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:25'!
isSouth
	^false.! !

!East methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:15'!
isWest
	^false.! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:33'!
isEast
	^false.! !

!North methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:40'!
isNorth
	^true.! !

!North methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:46'!
isSouth
	^false.! !

!North methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:50'!
isWest
	^false.! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:03:57'!
isEast
	^false.! !

!South methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:04:10'!
isNorth
	^false.! !

!South methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:04:02'!
isSouth
	^true.! !

!South methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:04:07'!
isWest
	^false.! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:04:26'!
isEast
	^false.! !

!West methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:04:29'!
isNorth
	^false.! !

!West methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:04:32'!
isSouth
	^false.! !

!West methodsFor: 'testing' stamp: 'LDM 5/13/2022 02:04:20'!
isWest
	^true.! !


!classDefinition: #CardinalMovement category: 'MarsRover'!
Object subclass: #CardinalMovement
	instanceVariableNames: 'direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/13/2022 01:21:26'!
leftClockwiseRotation
	self subclassResponsibility.! !

!CardinalMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/13/2022 01:28:34'!
rightCounterClockwiseRotation
	self subclassResponsibility.! !


!CardinalMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 01:40:31'!
backwardMovement
	self subclassResponsibility.! !

!CardinalMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 01:41:00'!
forwardMovement
	self subclassResponsibility.! !


!CardinalMovement methodsFor: 'as yet unclassified' stamp: 'LDM 5/13/2022 02:05:31'!
direction
	^direction.! !


!classDefinition: #EastPointMovement category: 'MarsRover'!
CardinalMovement subclass: #EastPointMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastPointMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/15/2022 02:03:52'!
leftClockwiseRotation
	^SouthPointMovement new.! !

!EastPointMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/15/2022 02:03:28'!
rightCounterClockwiseRotation
	^NorthPointMovement new.! !


!EastPointMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:31:55'!
backwardMovement
	^(-1@0)! !

!EastPointMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:31:59'!
forwardMovement
	^(1@0).! !


!EastPointMovement methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 04:39:15'!
initialize
	direction _ CardinalDirection east.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EastPointMovement class' category: 'MarsRover'!
EastPointMovement class
	instanceVariableNames: ''!

!EastPointMovement class methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 04:47:15'!
canHandle: aCardinalDirection
	^(aCardinalDirection isKindOf: East class).! !


!classDefinition: #NorthPointMovement category: 'MarsRover'!
CardinalMovement subclass: #NorthPointMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthPointMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/15/2022 02:03:05'!
leftClockwiseRotation
	^EastPointMovement new.! !

!NorthPointMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/15/2022 02:04:10'!
rightCounterClockwiseRotation
	^WestPointMovement new.! !


!NorthPointMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:32:03'!
backwardMovement
	^(0@-1).! !

!NorthPointMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:32:06'!
forwardMovement
	^(0@1).! !


!NorthPointMovement methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 02:17:15'!
initialize
	direction _ CardinalDirection north.
	position _ 0@0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NorthPointMovement class' category: 'MarsRover'!
NorthPointMovement class
	instanceVariableNames: ''!

!NorthPointMovement class methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 04:47:00'!
canHandle: aCardinalDirection
	^(aCardinalDirection isKindOf: North class).! !


!classDefinition: #SouthPointMovement category: 'MarsRover'!
CardinalMovement subclass: #SouthPointMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthPointMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/15/2022 02:04:10'!
leftClockwiseRotation
	^WestPointMovement new.! !

!SouthPointMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/15/2022 02:03:05'!
rightCounterClockwiseRotation
	^EastPointMovement new.! !


!SouthPointMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:32:10'!
backwardMovement
	^(0@1)! !

!SouthPointMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:32:13'!
forwardMovement
	^(0@-1)! !


!SouthPointMovement methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 02:17:21'!
initialize
	direction _ CardinalDirection south.
	position _ 0@0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SouthPointMovement class' category: 'MarsRover'!
SouthPointMovement class
	instanceVariableNames: ''!

!SouthPointMovement class methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 04:47:24'!
canHandle: aCardinalDirection
	^(aCardinalDirection isKindOf: South class).! !


!classDefinition: #WestPointMovement category: 'MarsRover'!
CardinalMovement subclass: #WestPointMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestPointMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/15/2022 02:03:28'!
leftClockwiseRotation
	^NorthPointMovement new.! !

!WestPointMovement methodsFor: 'clockwise rotation' stamp: 'LDM 5/15/2022 02:03:52'!
rightCounterClockwiseRotation
	^SouthPointMovement new.! !


!WestPointMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:32:17'!
backwardMovement
	^(1@0)! !

!WestPointMovement methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:32:19'!
forwardMovement
	^(-1@0)! !


!WestPointMovement methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 02:17:25'!
initialize
	direction _ CardinalDirection west.
	position _ 0@0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WestPointMovement class' category: 'MarsRover'!
WestPointMovement class
	instanceVariableNames: ''!

!WestPointMovement class methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 04:47:33'!
canHandle: aCardinalDirection
	^(aCardinalDirection isKindOf: West class).! !


!classDefinition: #CartesianPosition category: 'MarsRover'!
Object subclass: #CartesianPosition
	instanceVariableNames: 'marker'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CartesianPosition methodsFor: 'update' stamp: 'LDM 5/15/2022 02:25:39'!
movePositionWith: aPoint
	marker _ marker + aPoint.! !


!CartesianPosition methodsFor: 'init' stamp: 'LDM 5/15/2022 02:37:56'!
initialize
	"In order to simplify the model, we've decided to always start at Origin = <0,0>."
	marker _ 0@0.! !


!CartesianPosition methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:28:20'!
isAt: aPoint
	^marker = aPoint.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'movementSystem location'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'command processing' stamp: 'LDM 5/15/2022 04:28:44'!
executeBackwardMovement
	location movePositionWith: (movementSystem positionBackward)! !

!MarsRover methodsFor: 'command processing' stamp: 'LDM 5/15/2022 04:28:35'!
executeForwardMovement
	location movePositionWith: (movementSystem positionForward).! !

!MarsRover methodsFor: 'command processing' stamp: 'LDM 5/15/2022 04:29:24'!
executeLeftRotate
	movementSystem leftRotate.! !

!MarsRover methodsFor: 'command processing' stamp: 'LDM 5/15/2022 04:29:34'!
executeRightRotate
	movementSystem rightRotate.! !

!MarsRover methodsFor: 'command processing' stamp: 'LDM 5/15/2022 04:34:57'!
processCommand: aCommandSequence 
	aCommandSequence do: [:aCommand | (MarsRoverCommand for: aCommand) executeFor: self ].
	^self.! !


!MarsRover methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:30:49'!
isAt: aPoint
	^location isAt: aPoint.! !

!MarsRover methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:22:04'!
isHeadingToEast
	^movementSystem isHeadingToEast.! !

!MarsRover methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:22:04'!
isHeadingToNorth
	^movementSystem isHeadingToNorth.! !

!MarsRover methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:22:04'!
isHeadingToSouth
	^movementSystem isHeadingToSouth.! !

!MarsRover methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:22:04'!
isHeadingToWest
	^movementSystem isHeadingToWest.! !


!MarsRover methodsFor: 'instance creation' stamp: 'LDM 5/15/2022 02:30:33'!
heading: aCardinalDirection
	location _ CartesianPosition new.
	movementSystem _ MarsRoverMovementSystem with: aCardinalDirection.
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LDM 5/13/2022 00:59:46'!
heading: aCardinalDirection
	^self new heading: aCardinalDirection.! !


!classDefinition: #MarsRoverCommand category: 'MarsRover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommand methodsFor: 'command execution' stamp: 'LDM 5/15/2022 04:32:51'!
executeFor: aMarsRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'MarsRover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'LDM 5/15/2022 04:24:14'!
for: aCommand
	^(self subclasses detect: [:aCommandType | aCommandType canHandle: aCommand]) new.! !


!classDefinition: #BackwardCommand category: 'MarsRover'!
MarsRoverCommand subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!BackwardCommand methodsFor: 'command execution' stamp: 'LDM 5/15/2022 04:26:53'!
executeFor: aMarsRover
	aMarsRover executeBackwardMovement.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardCommand class' category: 'MarsRover'!
BackwardCommand class
	instanceVariableNames: ''!

!BackwardCommand class methodsFor: 'instance creation' stamp: 'LDM 5/15/2022 04:20:53'!
canHandle: aCommand
	^aCommand = $b.! !


!classDefinition: #ForwardCommand category: 'MarsRover'!
MarsRoverCommand subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!ForwardCommand methodsFor: 'command execution' stamp: 'LDM 5/15/2022 04:27:36'!
executeFor: aMarsRover
	aMarsRover executeForwardMovement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'MarsRover'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'instance creation' stamp: 'LDM 5/15/2022 04:17:43'!
canHandle: aCommand
	^aCommand = $f.! !


!classDefinition: #LeftRotateCommand category: 'MarsRover'!
MarsRoverCommand subclass: #LeftRotateCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!LeftRotateCommand methodsFor: 'command execution' stamp: 'LDM 5/15/2022 04:32:01'!
executeFor: aMarsRover
	aMarsRover executeLeftRotate.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftRotateCommand class' category: 'MarsRover'!
LeftRotateCommand class
	instanceVariableNames: ''!

!LeftRotateCommand class methodsFor: 'instance creation' stamp: 'LDM 5/15/2022 04:32:07'!
canHandle: aCommand
	^aCommand = $l.! !


!classDefinition: #RightRotateCommand category: 'MarsRover'!
MarsRoverCommand subclass: #RightRotateCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RightRotateCommand methodsFor: 'command execution' stamp: 'LDM 5/15/2022 04:32:25'!
executeFor: aMarsRover
	aMarsRover executeRightRotate.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightRotateCommand class' category: 'MarsRover'!
RightRotateCommand class
	instanceVariableNames: ''!

!RightRotateCommand class methodsFor: 'instance creation' stamp: 'LDM 5/15/2022 04:32:20'!
canHandle: aCommand
	^aCommand = $r.! !


!classDefinition: #MarsRoverMovementSystem category: 'MarsRover'!
Object subclass: #MarsRoverMovementSystem
	instanceVariableNames: 'cardinalMovement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverMovementSystem methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:15:38'!
isHeadingToEast
	^cardinalMovement direction isEast.! !

!MarsRoverMovementSystem methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:15:38'!
isHeadingToNorth
	^cardinalMovement direction isNorth.! !

!MarsRoverMovementSystem methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:15:38'!
isHeadingToSouth
	^cardinalMovement direction isSouth.! !

!MarsRoverMovementSystem methodsFor: 'testing' stamp: 'LDM 5/15/2022 02:15:38'!
isHeadingToWest
	^cardinalMovement direction isWest.! !


!MarsRoverMovementSystem methodsFor: 'rotation' stamp: 'LDM 5/15/2022 02:15:38'!
leftRotate
	cardinalMovement _ cardinalMovement leftClockwiseRotation.! !

!MarsRoverMovementSystem methodsFor: 'rotation' stamp: 'LDM 5/15/2022 02:15:38'!
rightRotate
	cardinalMovement _ cardinalMovement rightCounterClockwiseRotation.! !


!MarsRoverMovementSystem methodsFor: 'instance creation' stamp: 'LDM 5/15/2022 02:52:06'!
withDirection: aRotator
	cardinalMovement _ aRotator.! !


!MarsRoverMovementSystem methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:51:30'!
positionBackward
	^cardinalMovement backwardMovement.! !

!MarsRoverMovementSystem methodsFor: 'movement' stamp: 'LDM 5/15/2022 02:50:56'!
positionForward
	^cardinalMovement forwardMovement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverMovementSystem class' category: 'MarsRover'!
MarsRoverMovementSystem class
	instanceVariableNames: ''!

!MarsRoverMovementSystem class methodsFor: 'as yet unclassified' stamp: 'LDM 5/15/2022 04:50:11'!
with: aDirection
	^self new withDirection: (CardinalMovement subclasses detect: [:aCardinalMovementDirection | (aCardinalMovementDirection canHandle: aDirection) ]) new.
	! !
