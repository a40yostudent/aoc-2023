import Algorithms

struct Day06: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [String] {
		data.split(separator: "\n").map(String.init)
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		return 0
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		return 0
	}
}
