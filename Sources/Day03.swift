import Algorithms

struct Day03: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [String] {
		data.split(separator: "\n").map(String.init).map {"."+$0}
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		var parts: [Part] = []
		var symbols: [Symbol] = []
		
		var rowIndex = 0
		for line in entities {
			var partialNumber = 0
			var digitPos = 0
			
			// Scan every line reversed, so numbers can be added up while they're discovered
			// Symbols will be saved with reversed index
			var colIndex = 0
			for char in line.reversed() {
				// is a number
				if let number = char.wholeNumberValue {
					switch digitPos {
						case 2:
							partialNumber += number * 100
						case 1:
							partialNumber += number * 10
						default:
							partialNumber += number
					}
					digitPos += 1
				} else {
					// is a dot or a symbol
					// so if a number has been completed, save it
					if partialNumber > 0 {
						parts.append(Part(number: partialNumber,
										  region: (row: rowIndex - 1...rowIndex + 1,
												   col: colIndex - digitPos - 1...colIndex)))
						partialNumber = 0
						digitPos = 0
					}
					
					if !(char == ".") {
						// is a symbol
						symbols.append(Symbol(char: char, location: (row: rowIndex, col: colIndex)))
					}
				}
				
				colIndex += 1
			}
			
			rowIndex += 1
		}
		
		// validate all parts
		for (index, part) in parts.indexed() {
			for symbol in symbols {
				if part.region.row.contains(symbol.location.row) &&
					part.region.col.contains(symbol.location.col) {
					parts[index].isValid = true
				}
			}
		}
		return parts.filter { part in part.isValid }.map { part in part.number }.reduce(0, +)
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		return 0
	}
}

extension Day03 {
	private struct Part {
		let number: Int
		let region: (row: ClosedRange<Int>, col: ClosedRange<Int>)
		
		var isValid = false // to be toggled if a symbol is found in region proximity
	}
	
	private struct Symbol {
		let char: Character
		let location: (row: Int, col: Int)
	}
}
