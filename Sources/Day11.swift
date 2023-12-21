import Algorithms

struct Day11: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [Substring] {
		data.split(separator: "\n")
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		
		// find empty rows and cols
		var emptyRows = Array(0..<entities.count)
		var emptyCols = Array(0..<entities[0].count)
		var expandedMap =  [[Character]]()
		for (y, line) in entities.enumerated() {
			var newLine = [Character]()
			for (x, char) in line.enumerated() {
				switch char {
					case ".":
						newLine.append(char)
					case "#":
						newLine.append(char)
						if let galaxyAtX = emptyCols.firstIndex(of: x) {
							emptyCols.remove(at: galaxyAtX)
						}
						if let galaxyAtY = emptyRows.firstIndex(of: y) {
							emptyRows.remove(at: galaxyAtY)
						}
					default:
						fatalError("galaxy map loop")
				}
			}
			expandedMap.append(newLine)
		}
		
		// galaxy expansion
		let expEmptyRows = emptyRows.enumerated().map{ i, r in r + i }
		let expEmptyCols = emptyCols.enumerated().map{ i, c in c + i }
		for i in expEmptyRows {
			let emptyRow = Array(repeating: Character("."), count: expandedMap[0].count)
			expandedMap.insert(emptyRow, at: i)
		}
		for i in expEmptyCols {
			for j in 0..<expandedMap.count {
				expandedMap[j].insert(Character("."), at: i)
			}
		}
		
		// galaxy label
		var galaxiesList: [Int: (Int, Int)] = [:]
		var galaxyCounter = 0
		for (y, line) in expandedMap.enumerated() {
			for (x, char) in line.enumerated() {
				switch char {
					case ".":
						continue
					case "#":
						galaxiesList[galaxyCounter] = (x, y)
						galaxyCounter += 1
					default:
						fatalError("galaxy map loop")
				}
			}
		}
		
		// calculate lengths
		var lengths = [Int]()
		for g in 0..<(galaxiesList.count - 1) {
			for gg in (g + 1)..<galaxiesList.count {
				guard let galaxy1 = galaxiesList[g],
					  let galaxy2 = galaxiesList[gg] else {
					fatalError("lengths")
				}
				lengths.append(abs(galaxy1.0 - galaxy2.0) + abs(galaxy1.1 - galaxy2.1))
			}
		}
		
		// debug print map
		for line in expandedMap {
			print(String(line))
		}
		for galaxy in galaxiesList.sorted(by: {$0.key < $1.key}) {
			print(galaxy.key, ": ", galaxy.value)
		}
		
		return lengths.reduce(0, +)
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		// galaxy label
		var galaxiesList: [(Int, Int)] = []
		
		// empty space in universe
		var emptyRows = Array(0..<entities.count)
		var emptyCols = Array(0..<entities[0].count)
		
		var universeMap =  [[Character]]()
		
		for (y, line) in entities.enumerated() {
			var newLine = [Character]()
			for (x, char) in line.enumerated() {
				newLine.append(char)
				if char == "#" {
					
					// galaxy labelling
					galaxiesList.append((x, y))
					
					// empty space register
					if let galaxyAtX = emptyCols.firstIndex(of: x) {
						emptyCols.remove(at: galaxyAtX)
					}
					if let galaxyAtY = emptyRows.firstIndex(of: y) {
						emptyRows.remove(at: galaxyAtY)
					}
				}
			}
			universeMap.append(newLine)
		}
		
		// galaxy expansion
		let magnitude = 1_000_000 - 1 // multiplier for empty space
		let expandedGalaxiesList = galaxiesList.map { galaxy in
			let upperEmptyRows = emptyRows.filter{$0 < galaxy.1}.count
			let leadingEmptyCols = emptyCols.filter{$0 < galaxy.0}.count
			return (galaxy.0 + leadingEmptyCols * magnitude, galaxy.1 + upperEmptyRows * magnitude)
		}
		
		// calculate lengths
		var lengths = [Int]()
		for g in 0..<(expandedGalaxiesList.count - 1) {
			for gg in (g + 1)..<expandedGalaxiesList.count {
				let galaxy1 = expandedGalaxiesList[g]
				let galaxy2 = expandedGalaxiesList[gg]
				
				lengths.append(abs(galaxy1.0 - galaxy2.0) + abs(galaxy1.1 - galaxy2.1))
			}
		}
		
		return lengths.reduce(0, +)
	}
}
