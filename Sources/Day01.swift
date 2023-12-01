import Algorithms

struct Day01: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [Substring] {
		data.split(separator: "\n")
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		// Calculate the sum of the first set of input data
		return entities.map { line in
			let numbers = line.map(String.init).compactMap(Int.init)
			let first = numbers.first
			let last = numbers.last
			return first! * 10 + last!
		}.reduce(0, +)
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		// Sum the maximum entries in each set of data
//		entities.map { $0.max() ?? 0 }.reduce(0, +)
		return 0
	}
}
