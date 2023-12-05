import Algorithms

struct Day02: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [String] {
		data.split(separator: "\n").map(String.init)
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		var result = (1...100).reduce(0, +)
		
		for line in entities {
			let gameNumber = line.split(separator: ":")[0].split(separator: " ")[1]
			let gameSets = line.split(separator: ":")[1].split(separator: ";")
			
			var red = 0
			var green = 0
			var blue = 0
			for gameSet in gameSets {
				let gameSubSets = gameSet.split(separator: ",")
				for gameSubSet in gameSubSets {
					let quantity = gameSubSet.split(separator: " ")[0]
					let color = gameSubSet.split(separator: " ")[1]
					
					switch color {
						case "red":
							if Int(quantity)! > red { red = Int(quantity)! }
						case "green":
							if Int(quantity)! > green { green = Int(quantity)! }
						case "blue":
							if Int(quantity)! > blue { blue = Int(quantity)! }
						default:
							fatalError()
					}
				}
			}
			
			if red > 12 || green > 13 || blue > 14 {
				result -= Int(gameNumber)!
			}
		}
		
		return result // 2169
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		var result = 0
		
		for line in entities {
			let gameSets = line.split(separator: ":")[1].split(separator: ";")
			
			var red = 0
			var green = 0
			var blue = 0
			for gameSet in gameSets {
				let gameSubSets = gameSet.split(separator: ",")
				for gameSubSet in gameSubSets {
					let quantity = gameSubSet.split(separator: " ")[0]
					let color = gameSubSet.split(separator: " ")[1]
					
					switch color {
						case "red":
							if Int(quantity)! > red { red = Int(quantity)! }
						case "green":
							if Int(quantity)! > green { green = Int(quantity)! }
						case "blue":
							if Int(quantity)! > blue { blue = Int(quantity)! }
						default:
							fatalError()
					}
				}
			}
			
			result += red * green * blue
		}
		
		return result // 60948
	}
}
