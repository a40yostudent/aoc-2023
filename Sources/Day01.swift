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
		return entities.map { line in
			let numbers = line.map(String.init).compactMap(Int.init)
			let first = numbers.first
			let last = numbers.last
			return first! * 10 + last!
		}.reduce(0, +)
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		return entities.map { line in
			let line2 = String(line)
				.replacingOccurrences(of: "one", with: "1")
				// .replacingOccurrences(of: "two", with: "2")
				// .replacingOccurrences(of: "three", with: "3")
				// .replacingOccurrences(of: "four", with: "4")
				// .replacingOccurrences(of: "five", with: "5")
				// .replacingOccurrences(of: "six", with: "6")
				// .replacingOccurrences(of: "seven", with: "7")
				// .replacingOccurrences(of: "eight", with: "8")
				// .replacingOccurrences(of: "nine", with: "9")
			let numbers = line2.compactMap(Int.init)
			let first = numbers.first
			let last = numbers.last
			return first! * 10 + last!
		}.reduce(0, +)
	}
}
