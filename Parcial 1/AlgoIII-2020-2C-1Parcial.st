!classDefinition: #CoffeeShopTest category: 'AlgoIII-2020-2C-1Parcial'!
TestCase subclass: #CoffeeShopTest
	instanceVariableNames: 'billGates adaLovelace alanKay salesSystem combo1 combo2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopTest methodsFor: 'setUp/tearDown' stamp: 'AG 11/22/2020 14:47:12'!
setUp

	adaLovelace := CoffeeShopCustomer named: 'Ada Lovelace' ofType: #Gold.
	alanKay := CoffeeShopCustomer named: 'Alan Kay' ofType: #Silver.
	billGates := CoffeeShopCustomer named: 'Bill Gates' ofType: #Normal.
	
	salesSystem := CoffeeShopSalesSystem new.
	
	combo1 := Combo1 new.
	combo2 := Combo2 new. 
! !


!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'AG 11/22/2020 12:44:07'!
test01ThereAreNoSalesWhenSalesSystemIsCreated

	self assert: (salesSystem salesMadeTo: adaLovelace) isEmpty! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'AG 11/22/2020 14:47:45'!
test02CanQuerySalesByCustomer

	salesSystem registerSaleTo: adaLovelace of: combo1.
	
	self assertCustomer: adaLovelace wasSoldATotalOf: 1 ofWhich: 1 wereCombo: combo1.
	
	
	! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'AG 11/22/2020 14:48:23'!
test03SalesAreDistinguishedByCustomer

	salesSystem registerSaleTo: adaLovelace of: combo1.
	salesSystem registerSaleTo: adaLovelace of: combo1.
	salesSystem registerSaleTo: alanKay of: combo2.
	
	self assertCustomer: adaLovelace wasSoldATotalOf: 2 ofWhich: 2 wereCombo: combo1.
	self assertCustomer: alanKay wasSoldATotalOf: 1 ofWhich: 1 wereCombo: combo2.! !


!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'AG 11/22/2020 12:44:22'!
test04VolumeSoldToCustomerIsZeroWhenCustomerHasNoSaleRegistered

	| volumeSoldToCustomer |

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 0*milliliter equals: volumeSoldToCustomer! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'AG 11/22/2020 14:48:48'!
test05VolumeIs_250_WhenOnlyCombo1WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem registerSaleTo: adaLovelace of: combo1.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 250*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'AG 11/22/2020 14:48:59'!
test06VolumeIs_100_WhenOnlyCombo2WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem registerSaleTo: adaLovelace of: combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 100*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'AG 11/22/2020 14:49:08'!
test07VolumeSoldToCustomerIsTheSumOfAllSoldProducts

	| volumeSoldToCustomer |

	salesSystem registerSaleTo: adaLovelace of: combo1.
	salesSystem registerSaleTo: adaLovelace of: combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: (250*milliliter)+(100*milliliter) equals: volumeSoldToCustomer ! !


!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/22/2020 12:44:42'!
test08NoRewardExpectedWhenCustomerHasNotBuyAnything

	salesSystem rewardOf: adaLovelace ifNone: [ ^self ].
	
	self failWith: 'No reward expected when customer has not buy anything'! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/22/2020 14:49:31'!
test09GoldCustomerGetsRewardedWithOneCombo2With50PercentItsPriceWhenRule1Holds

	| adaLovelaceReward |
	
	salesSystem registerSaleTo: adaLovelace of: combo1.
	salesSystem registerSaleTo: adaLovelace of: combo2.

	adaLovelaceReward := salesSystem rewardOf: adaLovelace ifNone: [ self fail ].

	self assertCustomerReward: adaLovelaceReward 
		containsAQuantityOf: 1 
		forCombo: combo2 
		eachAtAPriceOf: 60*peso.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/22/2020 14:49:47'!
test10SilverCustomerGetsRewardedWithOneCombo2With75PercentItsPriceWhenRule1Holds

	| alaKayReward |

	salesSystem registerSaleTo: alanKay of: combo1.
	salesSystem registerSaleTo: alanKay of: combo2.

	alaKayReward := salesSystem rewardOf: alanKay ifNone: [ self fail ].

	self assertCustomerReward: alaKayReward 
		containsAQuantityOf: 1 
		forCombo: combo2 
		eachAtAPriceOf: 120*3/4*peso.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/22/2020 14:50:02'!
test11NormalCustomerGetsRewardedWithOneCombo2With90PercentItsPriceWhenRule1Holds

	| billGatesReward |

	salesSystem registerSaleTo: billGates of: combo1.
	salesSystem registerSaleTo: billGates of: combo2.

	billGatesReward := salesSystem rewardOf: billGates ifNone: [ self fail ].
	
	self assertCustomerReward: billGatesReward 
		containsAQuantityOf: 1 
		forCombo: combo2 
		eachAtAPriceOf: 120*9/10*peso.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/22/2020 14:50:16'!
test12GoldCustomerGetsRewardedWithOneCombo1At75PesosWhenRule2Holds

	| adaLovelaceReward |

	salesSystem registerSaleTo: adaLovelace of: combo1.
	salesSystem registerSaleTo: adaLovelace of: combo1.
	salesSystem registerSaleTo: adaLovelace of: combo2.

	adaLovelaceReward := salesSystem rewardOf: adaLovelace ifNone: [ self fail ].

	self assertCustomerReward: adaLovelaceReward 
		containsAQuantityOf: 2 
		forCombo: combo1 
		eachAtAPriceOf: 75*peso
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/22/2020 14:50:29'!
test13SilverCustomerGetsRewardedWithOneCombo1At83PesosWhenRule2Holds

	| alanKayReward |

	salesSystem registerSaleTo: alanKay of: combo1.
	salesSystem registerSaleTo: alanKay of: combo1.
	salesSystem registerSaleTo: alanKay of: combo2.

	alanKayReward := salesSystem rewardOf: alanKay ifNone: [ self fail ].

	self assertCustomerReward: alanKayReward 
		containsAQuantityOf: 2 
		forCombo: combo1 
		eachAtAPriceOf: 83*peso.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/22/2020 14:50:40'!
test14NormalCustomerGetsRewardedWithOneCombo1At97PesosWhenRule2Holds

	| billGatesReward |

	salesSystem registerSaleTo: billGates of: combo1.
	salesSystem registerSaleTo: billGates of: combo1.
	salesSystem registerSaleTo: billGates of: combo2.

	billGatesReward := salesSystem rewardOf: billGates ifNone: [ self fail ].

	self assertCustomerReward: billGatesReward 
		containsAQuantityOf: 2 
		forCombo: combo1 
		eachAtAPriceOf: 97*peso.
! !


!CoffeeShopTest methodsFor: 'assertions' stamp: 'AG 11/22/2020 11:38:44'!
assertCustomer: aCustomer wasSoldATotalOf: aTotalNumberOfCombosSold ofWhich: numberOfCombosOfTypeSold wereCombo: typeOfCombo

	| salesToCustomer |
	
	salesToCustomer := salesSystem salesMadeTo: aCustomer.
	
	self assert: aTotalNumberOfCombosSold equals: salesToCustomer size.
	self assert: numberOfCombosOfTypeSold equals: (salesToCustomer count: [ :aProduct | aProduct = typeOfCombo ]).! !

!CoffeeShopTest methodsFor: 'assertions' stamp: 'AG 11/22/2020 14:51:23'!
assertCustomerReward: aCustomerReward containsAQuantityOf: rewardedQuantity forCombo: rewardedCombo eachAtAPriceOf: rewardedPrice
	
	self assert: rewardedQuantity equals: aCustomerReward quantity.
	rewardedCombo = combo1 ifTrue: [self assert: aCustomerReward isForCombo1].
	rewardedCombo = combo2 ifTrue: [self assert: aCustomerReward isForCombo2].
	"self assert: aCustomerReward isForComboY."
	self assert: rewardedPrice equals: aCustomerReward price.! !


!classDefinition: #CoffeeShopCustomer category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopCustomer
	instanceVariableNames: 'name type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopCustomer methodsFor: 'type' stamp: 'LL 9/21/2020 13:05:10'!
type

	^type! !


!CoffeeShopCustomer methodsFor: 'initialization' stamp: 'LL 9/21/2020 13:00:45'!
initializeNamed: aName ofType: aType

	name := aName.
	type := aType ! !


!CoffeeShopCustomer methodsFor: 'printing' stamp: 'LL 9/22/2020 18:57:07'!
printOn: aStream

	aStream
		nextPutAll: 'Customer named ';
		nextPutAll: name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopCustomer class' category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer class
	instanceVariableNames: ''!

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'LL 9/21/2020 13:00:21'!
named: aName ofType: aType

	^self new initializeNamed: aName ofType: aType! !


!classDefinition: #CoffeeShopProducts category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopProducts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopProducts methodsFor: 'as yet unclassified' stamp: 'AG 11/22/2020 14:29:26'!
initialize 

	^self subclassResponsibility ! !

!CoffeeShopProducts methodsFor: 'as yet unclassified' stamp: 'AG 11/22/2020 14:29:02'!
price 

	^self subclassResponsibility ! !

!CoffeeShopProducts methodsFor: 'as yet unclassified' stamp: 'AG 11/22/2020 12:55:44'!
volume

	self subclassResponsibility ! !


!classDefinition: #Combo1 category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopProducts subclass: #Combo1
	instanceVariableNames: 'price volume'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo1 methodsFor: 'initialization' stamp: 'AG 11/22/2020 14:30:42'!
initialize
	
	price := 150*peso.
	volume := 250*milliliter.! !


!Combo1 methodsFor: 'as yet unclassified' stamp: 'AG 11/22/2020 12:58:46'!
price

	^price! !

!Combo1 methodsFor: 'as yet unclassified' stamp: 'AG 11/22/2020 13:02:55'!
volume
	
	^volume! !


!classDefinition: #Combo2 category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopProducts subclass: #Combo2
	instanceVariableNames: 'price volume'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo2 methodsFor: 'as yet unclassified' stamp: 'AG 11/22/2020 12:59:05'!
price
	
	^price! !

!Combo2 methodsFor: 'as yet unclassified' stamp: 'AG 11/22/2020 13:02:45'!
volume

	^volume! !


!Combo2 methodsFor: 'initialization' stamp: 'AG 11/22/2020 14:30:52'!
initialize
	
	price := 120*peso.
	volume := 100*milliliter.! !


!classDefinition: #CoffeeShopReward category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopReward
	instanceVariableNames: 'price quantity product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopReward methodsFor: 'accessing' stamp: 'LL 9/20/2020 17:54:42'!
price

	^price! !

!CoffeeShopReward methodsFor: 'accessing' stamp: 'LL 9/21/2020 16:31:13'!
quantity

	^quantity ! !


!CoffeeShopReward methodsFor: 'initialization' stamp: 'LL 9/22/2020 19:08:08'!
initializeOf: aProduct at: aPrice quantity: aQuantity

	product := aProduct.
	price := aPrice.
	quantity := aQuantity
	! !


!CoffeeShopReward methodsFor: 'testing' stamp: 'AG 11/22/2020 13:09:07'!
isForCombo1
	
	^product isKindOf: Combo1 ! !

!CoffeeShopReward methodsFor: 'testing' stamp: 'AG 11/22/2020 13:09:18'!
isForCombo2
	
	^product isKindOf: Combo2! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopReward class' category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopReward class
	instanceVariableNames: ''!

!CoffeeShopReward class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 17:53:14'!
of: aComboType at: aPrice quantity: aQuantity

	^self new initializeOf: aComboType at: aPrice quantity: aQuantity
! !


!classDefinition: #CoffeeShopSalesSystem category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopSalesSystem
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopSalesSystem methodsFor: 'product volume' stamp: 'AG 11/22/2020 12:55:02'!
volumeOf: aProduct

	^aProduct volume
	! !


!CoffeeShopSalesSystem methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:17:34'!
initialize

	sales := Dictionary new! !


!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'LL 9/22/2020 19:06:50'!
registerSaleTo: aCustomer of: aProduct

	| salesToCustomer |

	salesToCustomer := sales at: aCustomer ifAbsentPut: [ OrderedCollection new ].
	salesToCustomer add: aProduct ! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'LL 9/20/2020 17:24:49'!
salesMadeTo: aCustomer

	^sales at: aCustomer ifAbsent: [ #() ]! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'LL 9/22/2020 19:51:19'!
volumeSoldTo: aCustomer

	 ^(self salesMadeTo: aCustomer) sum: [ :aProduct | self volumeOf: aProduct ] ifEmpty: [ 0*milliliter ]! !


!CoffeeShopSalesSystem methodsFor: 'rewarding' stamp: 'LL 9/22/2020 19:53:42'!
rewardOf: aCustomer ifNone: noneBlock 

	| salesToCustomer volumeSoldToCustomer rewardRule |

	salesToCustomer := self salesMadeTo: aCustomer.
	volumeSoldToCustomer := self volumeSoldTo: aCustomer.
	
	rewardRule := RewardRule for: volumeSoldToCustomer ifNone: [^noneBlock value].
	^rewardRule createRewardFor: aCustomer.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopSalesSystem class' category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopSalesSystem class
	instanceVariableNames: ''!

!CoffeeShopSalesSystem class methodsFor: 'initialization' stamp: 'LL 9/23/2020 08:50:03'!
initialize

	Smalltalk at: #milliliter put: (BaseUnit named: 'milliliter')! !


!classDefinition: #RewardRule category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #RewardRule
	instanceVariableNames: 'product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 19:03:50'!
createRewardFor: aCustomer 
	
	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 10:51:26'!
productQuantity

	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 10:51:33'!
rewardedProduct

	self subclassResponsibility ! !


!RewardRule methodsFor: 'product price' stamp: 'AG 11/22/2020 13:03:30'!
priceOf: aProduct

	^aProduct price! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RewardRule class' category: 'AlgoIII-2020-2C-1Parcial'!
RewardRule class
	instanceVariableNames: ''!

!RewardRule class methodsFor: 'testing' stamp: 'LL 9/22/2020 19:53:22'!
isFor: volumeSoldToCustomer 
		
	self subclassResponsibility ! !


!RewardRule class methodsFor: 'instance creation' stamp: 'LL 9/22/2020 19:53:42'!
for: volumeSoldToCustomer ifNone: aNoneBlock

	^self subclasses 
		detect: [ :aRuleClass | aRuleClass isFor: volumeSoldToCustomer ] 
		ifFound: [ :aRuleClass | aRuleClass new ]
		ifNone: aNoneBlock ! !


!classDefinition: #Combo1RewardRule category: 'AlgoIII-2020-2C-1Parcial'!
RewardRule subclass: #Combo1RewardRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 21:41:45'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	
	aCustomer type = #Gold ifTrue: [ price := 75*peso ].
	aCustomer type = #Silver ifTrue: [ price := 83*peso ].
	aCustomer type = #Normal ifTrue: [ price := 97*peso ].
	
	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 19:54:35'!
productQuantity
	
	^2! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'AG 11/22/2020 13:07:09'!
rewardedProduct
	
	^Combo1 new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo1RewardRule class' category: 'AlgoIII-2020-2C-1Parcial'!
Combo1RewardRule class
	instanceVariableNames: ''!

!Combo1RewardRule class methodsFor: 'testing' stamp: 'LL 9/22/2020 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer > (500*milliliter)! !


!classDefinition: #Combo2RewardRule category: 'AlgoIII-2020-2C-1Parcial'!
RewardRule subclass: #Combo2RewardRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 21:41:45'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	
	aCustomer type = #Gold ifTrue: [ price := (self priceOf: product)/2 ].
	aCustomer type = #Silver ifTrue: [ price := (self priceOf: product)*3/4 ].
	aCustomer type = #Normal ifTrue: [ price := (self priceOf: product)*9/10 ].
	
	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 10:23:07'!
productQuantity

	^1! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'AG 11/22/2020 13:07:16'!
rewardedProduct
	
	^Combo2 new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo2RewardRule class' category: 'AlgoIII-2020-2C-1Parcial'!
Combo2RewardRule class
	instanceVariableNames: ''!

!Combo2RewardRule class methodsFor: 'testing' stamp: 'LL 9/22/2020 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer between: 300*milliliter and: 500*milliliter
	! !

CoffeeShopSalesSystem initialize!