!classDefinition: #CoffeeShopTest category: 'AlgoIII-2020-2C-1Parcial'!
TestCase subclass: #CoffeeShopTest
	instanceVariableNames: 'billGates adaLovelace alanKay salesSystem aCombo1 aCombo2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopTest methodsFor: 'setUp/tearDown' stamp: 'AG 11/23/2020 08:28:13'!
setUp

	adaLovelace := GoldCustomer named: 'Ada Lovelace'.
	alanKay := SilverCustomer named: 'Alan Kay'.
	billGates := NormalCustomer named: 'Bill Gates'.
	
	salesSystem := CoffeeShopSalesSystem new.
	
	aCombo1 := Combo1 new.
	aCombo2 := Combo2 new. 
! !


!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'AG 11/22/2020 12:44:07'!
test01ThereAreNoSalesWhenSalesSystemIsCreated

	self assert: (salesSystem salesMadeTo: adaLovelace) isEmpty! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'AG 11/23/2020 08:40:40'!
test02CanQuerySalesByCustomer

	salesSystem registerSaleTo: adaLovelace of: aCombo1.
	
	self assertCustomer: adaLovelace wasSoldATotalOf: 1 ofWhich: 1 were: aCombo1.
	
	
	! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'AG 11/23/2020 08:40:40'!
test03SalesAreDistinguishedByCustomer

	salesSystem registerSaleTo: adaLovelace of: aCombo1.
	salesSystem registerSaleTo: adaLovelace of: aCombo1.
	salesSystem registerSaleTo: alanKay of: aCombo2.
	
	self assertCustomer: adaLovelace wasSoldATotalOf: 2 ofWhich: 2 were: aCombo1.
	self assertCustomer: alanKay wasSoldATotalOf: 1 ofWhich: 1 were: aCombo2.! !


!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'AG 11/22/2020 12:44:22'!
test04VolumeSoldToCustomerIsZeroWhenCustomerHasNoSaleRegistered

	| volumeSoldToCustomer |

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 0*milliliter equals: volumeSoldToCustomer! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'AG 11/23/2020 08:34:57'!
test05VolumeIs_250_WhenOnlyCombo1WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem registerSaleTo: adaLovelace of: aCombo1.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 250*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'AG 11/23/2020 08:35:02'!
test06VolumeIs_100_WhenOnlyCombo2WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem registerSaleTo: adaLovelace of: aCombo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 100*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'AG 11/23/2020 08:35:10'!
test07VolumeSoldToCustomerIsTheSumOfAllSoldProducts

	| volumeSoldToCustomer |

	salesSystem registerSaleTo: adaLovelace of: aCombo1.
	salesSystem registerSaleTo: adaLovelace of: aCombo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: (250*milliliter)+(100*milliliter) equals: volumeSoldToCustomer ! !


!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/22/2020 12:44:42'!
test08NoRewardExpectedWhenCustomerHasNotBuyAnything

	salesSystem rewardOf: adaLovelace ifNone: [ ^self ].
	
	self failWith: 'No reward expected when customer has not buy anything'! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/23/2020 08:42:22'!
test09GoldCustomerGetsRewardedWithOneCombo2With50PercentItsPriceWhenRule1Holds

	| adaLovelaceReward |
	
	salesSystem registerSaleTo: adaLovelace of: aCombo1.
	salesSystem registerSaleTo: adaLovelace of: aCombo2.

	adaLovelaceReward := salesSystem rewardOf: adaLovelace ifNone: [ self fail ].

	self assertCustomerReward: adaLovelaceReward 
		containsAQuantityOf: 1 
		forProduct: aCombo2 
		eachAtAPriceOf: 60*peso.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/23/2020 08:44:07'!
test10SilverCustomerGetsRewardedWithOneCombo2With75PercentItsPriceWhenRule1Holds

	| alaKayReward |

	salesSystem registerSaleTo: alanKay of: aCombo1.
	salesSystem registerSaleTo: alanKay of: aCombo2.

	alaKayReward := salesSystem rewardOf: alanKay ifNone: [ self fail ].

	self assertCustomerReward: alaKayReward 
		containsAQuantityOf: 1 
		forProduct: aCombo2 
		eachAtAPriceOf: 120*3/4*peso.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/23/2020 08:43:59'!
test11NormalCustomerGetsRewardedWithOneCombo2With90PercentItsPriceWhenRule1Holds

	| billGatesReward |

	salesSystem registerSaleTo: billGates of: aCombo1.
	salesSystem registerSaleTo: billGates of: aCombo2.

	billGatesReward := salesSystem rewardOf: billGates ifNone: [ self fail ].
	
	self assertCustomerReward: billGatesReward 
		containsAQuantityOf: 1 
		forProduct: aCombo2 
		eachAtAPriceOf: 120*9/10*peso.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/23/2020 08:43:48'!
test12GoldCustomerGetsRewardedWithOneCombo1At75PesosWhenRule2Holds

	| adaLovelaceReward |

	salesSystem registerSaleTo: adaLovelace of: aCombo1.
	salesSystem registerSaleTo: adaLovelace of: aCombo1.
	salesSystem registerSaleTo: adaLovelace of: aCombo2.

	adaLovelaceReward := salesSystem rewardOf: adaLovelace ifNone: [ self fail ].

	self assertCustomerReward: adaLovelaceReward 
		containsAQuantityOf: 2 
		forProduct: aCombo1 
		eachAtAPriceOf: 75*peso
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/23/2020 08:43:39'!
test13SilverCustomerGetsRewardedWithOneCombo1At83PesosWhenRule2Holds

	| alanKayReward |

	salesSystem registerSaleTo: alanKay of: aCombo1.
	salesSystem registerSaleTo: alanKay of: aCombo1.
	salesSystem registerSaleTo: alanKay of: aCombo2.

	alanKayReward := salesSystem rewardOf: alanKay ifNone: [ self fail ].

	self assertCustomerReward: alanKayReward 
		containsAQuantityOf: 2 
		forProduct: aCombo1 
		eachAtAPriceOf: 83*peso.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'AG 11/23/2020 08:43:30'!
test14NormalCustomerGetsRewardedWithOneCombo1At97PesosWhenRule2Holds

	| billGatesReward |

	salesSystem registerSaleTo: billGates of: aCombo1.
	salesSystem registerSaleTo: billGates of: aCombo1.
	salesSystem registerSaleTo: billGates of: aCombo2.

	billGatesReward := salesSystem rewardOf: billGates ifNone: [ self fail ].

	self assertCustomerReward: billGatesReward 
		containsAQuantityOf: 2 
		forProduct: aCombo1 
		eachAtAPriceOf: 97*peso.
! !


!CoffeeShopTest methodsFor: 'assertions' stamp: 'AG 11/23/2020 08:41:39'!
assertCustomer: aCustomer wasSoldATotalOf: aTotalNumberOfProductsSold ofWhich: numberOfSpecificProductsSold were: aProductType

	| salesToCustomer |
	
	salesToCustomer := salesSystem salesMadeTo: aCustomer.
	
	self assert: aTotalNumberOfProductsSold equals: salesToCustomer size.
	self assert: numberOfSpecificProductsSold equals: (salesToCustomer count: [ :aProduct | aProduct = aProductType ]).! !

!CoffeeShopTest methodsFor: 'assertions' stamp: 'AG 11/23/2020 08:42:58'!
assertCustomerReward: aCustomerReward containsAQuantityOf: rewardedQuantity forProduct: rewardedProduct eachAtAPriceOf: rewardedPrice
	
	self assert: rewardedQuantity equals: aCustomerReward quantity.
	self assert: (rewardedProduct isRewardedIn: aCustomerReward).
	self assert: rewardedPrice equals: aCustomerReward price.! !


!classDefinition: #CoffeeShopCustomer category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopCustomer
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopCustomer methodsFor: 'initialization' stamp: 'AG 11/22/2020 16:28:20'!
initializeNamed: aName

	name := aName.
! !


!CoffeeShopCustomer methodsFor: 'printing' stamp: 'LL 9/22/2020 18:57:07'!
printOn: aStream

	aStream
		nextPutAll: 'Customer named ';
		nextPutAll: name! !


!CoffeeShopCustomer methodsFor: 'reward prices' stamp: 'AG 11/23/2020 09:23:21'!
rewardPriceForCombo1

	^self subclassResponsibility ! !

!CoffeeShopCustomer methodsFor: 'reward prices' stamp: 'AG 11/23/2020 09:23:39'!
rewardPriceForCombo2: aCombo2

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopCustomer class' category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer class
	instanceVariableNames: ''!

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'AG 11/22/2020 16:27:58'!
named: aName

	^self new initializeNamed: aName
	! !


!classDefinition: #GoldCustomer category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer subclass: #GoldCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!GoldCustomer methodsFor: 'reward prices' stamp: 'AG 11/22/2020 16:17:32'!
rewardPriceForCombo1
	
	^75*peso! !

!GoldCustomer methodsFor: 'reward prices' stamp: 'AG 11/23/2020 09:25:03'!
rewardPriceForCombo2: aCombo2
	
	^aCombo2 price / 2! !


!classDefinition: #NormalCustomer category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer subclass: #NormalCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!NormalCustomer methodsFor: 'reward prices' stamp: 'AG 11/22/2020 16:18:15'!
rewardPriceForCombo1
	
	^97*peso! !

!NormalCustomer methodsFor: 'reward prices' stamp: 'AG 11/23/2020 09:24:50'!
rewardPriceForCombo2: aCombo2
	
	^aCombo2 price * 9 / 10! !


!classDefinition: #SilverCustomer category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer subclass: #SilverCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!SilverCustomer methodsFor: 'reward prices' stamp: 'AG 11/22/2020 16:18:21'!
rewardPriceForCombo1
	
	^83*peso! !

!SilverCustomer methodsFor: 'reward prices' stamp: 'AG 11/23/2020 09:24:27'!
rewardPriceForCombo2: aCombo2
	
	^aCombo2 price * 3 / 4! !


!classDefinition: #CoffeeShopProducts category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopProducts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopProducts methodsFor: 'accessing' stamp: 'AG 11/22/2020 14:29:02'!
price 

	^self subclassResponsibility ! !

!CoffeeShopProducts methodsFor: 'accessing' stamp: 'AG 11/22/2020 12:55:44'!
volume

	self subclassResponsibility ! !


!CoffeeShopProducts methodsFor: 'initialization' stamp: 'AG 11/22/2020 14:29:26'!
initialize 

	^self subclassResponsibility ! !


!CoffeeShopProducts methodsFor: 'rewarding system' stamp: 'AG 11/22/2020 15:39:00'!
isRewardedIn: aCustomerReward

	^self subclassResponsibility ! !


!classDefinition: #Combo1 category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopProducts subclass: #Combo1
	instanceVariableNames: 'price volume'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo1 methodsFor: 'accessing' stamp: 'AG 11/22/2020 12:58:46'!
price

	^price! !

!Combo1 methodsFor: 'accessing' stamp: 'AG 11/22/2020 13:02:55'!
volume
	
	^volume! !


!Combo1 methodsFor: 'initialization' stamp: 'AG 11/22/2020 14:30:42'!
initialize
	
	price := 150*peso.
	volume := 250*milliliter.! !


!Combo1 methodsFor: 'rewarding system' stamp: 'AG 11/23/2020 09:38:12'!
isRewardedIn: aCustomerReward

	^aCustomerReward isForProduct: self.! !


!classDefinition: #Combo2 category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopProducts subclass: #Combo2
	instanceVariableNames: 'price volume'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo2 methodsFor: 'initialization' stamp: 'AG 11/22/2020 14:30:52'!
initialize
	
	price := 120*peso.
	volume := 100*milliliter.! !


!Combo2 methodsFor: 'accessing' stamp: 'AG 11/22/2020 12:59:05'!
price
	
	^price! !

!Combo2 methodsFor: 'accessing' stamp: 'AG 11/22/2020 13:02:45'!
volume

	^volume! !


!Combo2 methodsFor: 'rewarding system' stamp: 'AG 11/23/2020 09:38:12'!
isRewardedIn: aCustomerReward

	^aCustomerReward isForProduct: self.! !


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


!CoffeeShopReward methodsFor: 'testing' stamp: 'AG 11/23/2020 09:38:29'!
isForProduct: aProduct

	^product isKindOf: aProduct class.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopReward class' category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopReward class
	instanceVariableNames: ''!

!CoffeeShopReward class methodsFor: 'instance creation' stamp: 'AG 11/23/2020 09:37:36'!
of: aProductType at: aPrice quantity: aQuantity

	^self new initializeOf: aProductType at: aPrice quantity: aQuantity
! !


!classDefinition: #CoffeeShopSalesSystem category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopSalesSystem
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

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

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'AG 11/22/2020 16:05:51'!
volumeSoldTo: aCustomer

	 ^(self salesMadeTo: aCustomer) sum: [ :aProduct | aProduct volume ] ifEmpty: [ 0*milliliter ]! !


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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 19:03:50'!
createRewardFor: aCustomer 
	
	self subclassResponsibility ! !


!RewardRule methodsFor: 'initialization' stamp: 'AG 11/23/2020 09:58:11'!
initialize
	
	^self subclassResponsibility ! !

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
	instanceVariableNames: 'rewardedProduct rewardedQuantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'AG 11/23/2020 09:56:58'!
createRewardFor: aCustomer 
	
	| price |
	
	price := aCustomer rewardPriceForCombo1.
		
	^CoffeeShopReward of: rewardedProduct at: price quantity: rewardedQuantity! !


!Combo1RewardRule methodsFor: 'initialization' stamp: 'AG 11/23/2020 09:56:30'!
initialize
	
	rewardedProduct := Combo1 new.
	rewardedQuantity := 2.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo1RewardRule class' category: 'AlgoIII-2020-2C-1Parcial'!
Combo1RewardRule class
	instanceVariableNames: ''!

!Combo1RewardRule class methodsFor: 'testing' stamp: 'LL 9/22/2020 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer > (500*milliliter)! !


!classDefinition: #Combo2RewardRule category: 'AlgoIII-2020-2C-1Parcial'!
RewardRule subclass: #Combo2RewardRule
	instanceVariableNames: 'rewardedProduct rewardedQuantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'AG 11/23/2020 09:57:07'!
createRewardFor: aCustomer 
	
	| price |
	
	price := aCustomer rewardPriceForCombo2: rewardedProduct.
		
	^CoffeeShopReward of: rewardedProduct at: price quantity: rewardedQuantity! !


!Combo2RewardRule methodsFor: 'initialization' stamp: 'AG 11/23/2020 09:56:02'!
initialize
	
	rewardedProduct := Combo2 new.
	rewardedQuantity := 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo2RewardRule class' category: 'AlgoIII-2020-2C-1Parcial'!
Combo2RewardRule class
	instanceVariableNames: ''!

!Combo2RewardRule class methodsFor: 'testing' stamp: 'LL 9/22/2020 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer between: 300*milliliter and: 500*milliliter
	! !

CoffeeShopSalesSystem initialize!