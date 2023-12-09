import Algorithms

struct Day07: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [Substring] {
		data.split(separator: "\n")
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		var hands: [Hand] = []
		for line in entities {
			let components = line.split(separator: " ").map(String.init)
			let cardsComponent = components[0]
			let bid = Int(components[1])!
			var cards: [Card] = []
			for card in cardsComponent {
				switch card {
					case "2":
						cards.append(._2)
					case "3":
						cards.append(._3)
					case "4":
						cards.append(._4)
					case "5":
						cards.append(._5)
					case "6":
						cards.append(._6)
					case "7":
						cards.append(._7)
					case "8":
						cards.append(._8)
					case "9":
						cards.append(._9)
					case "T":
						cards.append(._T)
					case "J":
						cards.append(._J)
					case "Q":
						cards.append(._Q)
					case "K":
						cards.append(._K)
					case "A":
						cards.append(._A)
					default:
						fatalError("unknown card")
				}
			}
			hands.append(Hand(cards: cards, bid: bid))
		}
		return hands.sorted().enumerated().map{index, card in index.advanced(by: 1) * card.bid}.reduce(0, +)
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		var hands: [JHand] = []
		for line in entities {
			let components = line.split(separator: " ").map(String.init)
			let cardsComponent = components[0]
			let bid = Int(components[1])!
			var cards: [JCard] = []
			for card in cardsComponent {
				switch card {
					case "2":
						cards.append(._2)
					case "3":
						cards.append(._3)
					case "4":
						cards.append(._4)
					case "5":
						cards.append(._5)
					case "6":
						cards.append(._6)
					case "7":
						cards.append(._7)
					case "8":
						cards.append(._8)
					case "9":
						cards.append(._9)
					case "T":
						cards.append(._T)
					case "J":
						cards.append(._J)
					case "Q":
						cards.append(._Q)
					case "K":
						cards.append(._K)
					case "A":
						cards.append(._A)
					default:
						fatalError("unknown card")
				}
			}
			hands.append(JHand(cards: cards, bid: bid))
		}
		for hand in hands {
			hand.debugPrint()
		}
		
		return hands.sorted().enumerated().map{index, card in index.advanced(by: 1) * card.bid}.reduce(0, +)
	}
}

extension Day07 {
	fileprivate
	enum Card: Int {
		case _2, _3, _4, _5, _6, _7, _8, _9, _T, _J, _Q, _K, _A
	}
	
	fileprivate
	enum JCard: Int {
		case _J, _2, _3, _4, _5, _6, _7, _8, _9, _T, _Q, _K, _A
	}
	
	fileprivate
	struct Hand {
		let cards: [Card]
		let bid: Int
		
		enum _Type: Int {
			case _1, _2, _22, _3, _23, _4, _5
		}
		
		var type: _Type {
			let cardSet = Set(cards)
			switch cardSet.count {
				case 5:
					return ._1
				case 4:
					return ._2
				case 3:
					var occurrencies = 0
					for card in cardSet {
						let count = cards.filter{$0 == card}.count
						if count > occurrencies {
							occurrencies = count
						}
					}
					return occurrencies > 2 ? ._3 : ._22
				case 2:
					var occurrencies = 0
					for card in cardSet {
						let count = cards.filter{$0 == card}.count
						if count > occurrencies {
							occurrencies = count
						}
					}
					return occurrencies > 3 ? ._4 : ._23
				case 1:
					return ._5
				default:
					fatalError("cannot infer hand type")
			}
		}
	}
	
	fileprivate
	struct JHand {
		let cards: [JCard]
		let bid: Int
		
		enum _Type: Int {
			case _1, _2, _22, _3, _23, _4, _5
		}
		
		func debugPrint() {
			print(self.cards, " -> ", self.cards_noj, " : ", self.type)
		}
		
		var cards_noj: [JCard] {
			var cards_noj = cards.filter{$0 != ._J}
			switch cards_noj.count {
				case 0, 5:
					cards_noj = cards
				default:
					var occurrencies = 0
					var bestCard: JCard?
					for card in cards_noj {
						let count = cards_noj.filter{$0 == card}.count
						if count > occurrencies {
							occurrencies = count
							bestCard = card
						}
					}
					for _ in 0..<(cards.count - cards_noj.count) {
						cards_noj.append(bestCard!)
					}
			}
			return cards_noj
		}
		
		var type: _Type {
			let cardSet = Set(self.cards_noj)
			switch cardSet.count {
				case 5:
					return ._1
				case 4:
					return ._2
				case 3:
					var occurrencies = 0
					for card in cardSet {
						let count = cards_noj.filter{$0 == card}.count
						if count > occurrencies {
							occurrencies = count
						}
					}
					return occurrencies > 2 ? ._3 : ._22
				case 2:
					var occurrencies = 0
					for card in cardSet {
						let count = cards_noj.filter{$0 == card}.count
						if count > occurrencies {
							occurrencies = count
						}
					}
					return occurrencies > 3 ? ._4 : ._23
				case 1:
					return ._5
				default:
					fatalError("cannot infer hand type")
			}
		}
	}
}

extension Day07.Card: Comparable {
	static func < (lhs: Day07.Card, rhs: Day07.Card) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}

extension Day07.JCard: Comparable {
	static func < (lhs: Day07.JCard, rhs: Day07.JCard) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}

extension Day07.JCard: CustomDebugStringConvertible {
	var debugDescription: String {
		switch self {
			case ._2:
				return "2"
			case ._3:
				return "3"
			case ._4:
				return "4"
			case ._5:
				return "5"
			case ._6:
				return "6"
			case ._7:
				return "7"
			case ._8:
				return "8"
			case ._9:
				return "9"
			case ._T:
				return "T"
			case ._J:
				return "J"
			case ._Q:
				return "Q"
			case ._K:
				return "K"
			case ._A:
				return "A"
		}
	}
}

extension Day07.Hand: Comparable {
	static func < (lhs: Day07.Hand, rhs: Day07.Hand) -> Bool {
		if lhs.type != rhs.type {
			return lhs.type.rawValue < rhs.type.rawValue
		}
		
		if lhs.cards[0].rawValue != rhs.cards[0].rawValue {
			return lhs.cards[0].rawValue < rhs.cards[0].rawValue
		}
		
		if lhs.cards[1].rawValue != rhs.cards[1].rawValue {
			return lhs.cards[1].rawValue < rhs.cards[1].rawValue
		}
		
		if lhs.cards[2].rawValue != rhs.cards[2].rawValue {
			return lhs.cards[2].rawValue < rhs.cards[2].rawValue
		}
		
		if lhs.cards[3].rawValue != rhs.cards[3].rawValue {
			return lhs.cards[3].rawValue < rhs.cards[3].rawValue
		}
		
		return lhs.cards[4].rawValue < rhs.cards[4].rawValue
	}
}

extension Day07.JHand: Comparable {
	static func < (lhs: Day07.JHand, rhs: Day07.JHand) -> Bool {
		if lhs.type != rhs.type {
			return lhs.type.rawValue < rhs.type.rawValue
		}
		
		if lhs.cards[0].rawValue != rhs.cards[0].rawValue {
			return lhs.cards[0].rawValue < rhs.cards[0].rawValue
		}
		
		if lhs.cards[1].rawValue != rhs.cards[1].rawValue {
			return lhs.cards[1].rawValue < rhs.cards[1].rawValue
		}
		
		if lhs.cards[2].rawValue != rhs.cards[2].rawValue {
			return lhs.cards[2].rawValue < rhs.cards[2].rawValue
		}
		
		if lhs.cards[3].rawValue != rhs.cards[3].rawValue {
			return lhs.cards[3].rawValue < rhs.cards[3].rawValue
		}
		
		return lhs.cards[4].rawValue < rhs.cards[4].rawValue
	}
}
