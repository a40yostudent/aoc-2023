import Foundation

struct Day04: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [String] {
		data.split(separator: "\n").map(String.init)
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		var totalPoints = 0
		
		for line in entities {
			let winningNumbers = line.split(separator: "|")[0].split(separator: ":")[1].split(separator: " ").map(String.init).compactMap(Int.init)
			let numbersYouHave = line.split(separator: "|")[1].split(separator: " ").map(String.init).compactMap(Int.init)
			
			var cardPoints = -1
			for winningNumber in winningNumbers {
				if numbersYouHave.contains(winningNumber) {
					cardPoints += 1
				}
			}
			
			if cardPoints > -1 {
				totalPoints += Int(Int(truncating: pow(2, cardPoints) as NSNumber))
			}
			
			// print(winningNumbers, numbersYouHave, pow(2, cardPoints))
		}
		
		return totalPoints
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		var totalCards: [Card] = []
		
		for line in entities {
			let cardNumber = line.split(separator: "|")[0].split(separator: ":")[0].split(separator: " ")[1].map(String.init).compactMap(Int.init).first!
			let winningNumbers = line.split(separator: "|")[0].split(separator: ":")[1].split(separator: " ").map(String.init).compactMap(Int.init)
			let numbersYouHave = line.split(separator: "|")[1].split(separator: " ").map(String.init).compactMap(Int.init)
			
			var cardPoints = 0
			for winningNumber in winningNumbers {
				if numbersYouHave.contains(winningNumber) {
					cardPoints += 1
				}
			}
			
			totalCards.append(Card(number: cardNumber, matchingNumbers: cardPoints))
		}
		
		// mutating an array while iterating it... if you know, you know.
		for j in 0..<totalCards.count {
			if totalCards[j].matchingNumbers > 0 {
				for i in 1...totalCards[j].matchingNumbers {
					if totalCards.count > j+i {
						totalCards[j+i].copies += totalCards[j].copies
					}
				}
			}
		}
		
		return totalCards.map{$0.copies}.reduce(0, +)
	}
}
extension Day04 {
	private struct Card {
		let number: Int
		let matchingNumbers: Int
		
		var copies = 1
	}
}
