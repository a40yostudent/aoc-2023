import Algorithms

struct Day12: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [(String, [Int])] {
		data.split(separator: "\n").map { line in
			let record = String(line.split(separator: " ")[0])
			let control = line.split(separator: " ")[1].split(separator: ",").map(String.init).compactMap(Int.init)
			
			return (record, control)
		}
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
