import Algorithms

struct Day09: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [[Int]] {
		var entities: [[Int]] = []
		let lines = data.split(separator: "\n")
		for line in lines {
			entities.append(line.split(separator: " ").map(String.init).compactMap(Int.init))
		}
		return entities
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		var values = [Int]()
		
		for sequence in entities {
			// save all final numbers of sequence
			var lastNumbers = [Int]()
			lastNumbers.append(sequence.last!)
			
			// extrapolate the sequence until all elements are zeroed, saving the last of the array
			var newSequence = sequence
			repeat {
				newSequence = extrapolate(newSequence)
				lastNumbers.append(newSequence.last!)
			} while !newSequence.filter({$0 != 0}).isEmpty
			
			values.append(lastNumbers.reduce(0, +))
		}

		return values.reduce(0, +)
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		var values = [Int]()
		
		for sequence in entities {
			// save all final numbers of sequence
			var lastNumbers = [Int]()
			lastNumbers.append(sequence.first!) // here save the first because the collection will be reversed
			
			// extrapolate the sequence, reversed, until all elements are zeroed, saving the last of the array
			var newSequence = Array(sequence.reversed())
			repeat {
				newSequence = extrapolate(newSequence)
				lastNumbers.append(newSequence.last!)
			} while !newSequence.filter({$0 != 0}).isEmpty
			
			values.append(lastNumbers.reduce(0, +))
		}
		
		return values.reduce(0, +)
	}
}

extension Day09 {
	private func extrapolate(_ sequence: [Int]) -> [Int] {
		return sequence.adjacentPairs().map{$0.1 - $0.0}
	}
}
