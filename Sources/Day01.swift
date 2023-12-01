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
				.replacingOccurrences(of: "one", with: "o1e")
				.replacingOccurrences(of: "two", with: "t2o")
				.replacingOccurrences(of: "three", with: "t3e")
				.replacingOccurrences(of: "four", with: "f4r")
				.replacingOccurrences(of: "five", with: "f5e")
				.replacingOccurrences(of: "six", with: "s6x")
				.replacingOccurrences(of: "seven", with: "s7n")
				.replacingOccurrences(of: "eight", with: "e8t")
				.replacingOccurrences(of: "nine", with: "n9e")
			let numbers = line2.map(String.init).compactMap(Int.init)
			let first = numbers.first
			let last = numbers.last
			return first! * 10 + last!
		}.reduce(0, +)
	}
}
