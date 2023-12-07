import Algorithms

struct Day05: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [String] {
		data.split(separator: "\n\n").map(String.init)
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		let seeds = entities[0].split(separator: ":")[1].split(separator: " ").map(String.init).compactMap(Int.init)
		var lowerLocation = Int.max

		var mapsGroup = [[Map]]()
		for i in 1...7 {
			mapsGroup.append(createMap(withGroup: i))
		}
		
		for seed in seeds {
			var transformed = seed
//			print("START: ", transformed)
			for maps in mapsGroup {
			mapsLoop:
				for map in maps {
					let sourceRange = map.sourceRangeStart..<(map.sourceRangeStart + map.rangeLength)
					if (sourceRange).contains(transformed) {
						transformed = transformed - (map.sourceRangeStart - map.destinationRangeStart)
//						print("INRANGE: ", transformed)
						break mapsLoop
					} else {
//						print("NOTINRANGE: ", transformed)
					}
				}
			}
//			print("END: ", transformed)
			lowerLocation = (transformed > lowerLocation) ? lowerLocation : transformed
		}

		return lowerLocation
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		let seeds = entities[0].split(separator: ":")[1].split(separator: " ").map(String.init).compactMap(Int.init)
		var seedsRanges: [Range<Int>] = []
		for i in stride(from: 0, to: seeds.count, by: 2) {
			seedsRanges.append(seeds[i]..<(seeds[i] + seeds[i + 1]))
		}
		
		//
		// utilities:
		// seedsRanges[0].overlaps(<#T##other: Range<Int>##Range<Int>#>)
		// seedsRanges[0].clamped(to: <#T##Range<Int>#>)
		
		var lowerLocation = Int.max
		
		var mapsGroupProvv = [[Map]]()
		for i in 1...7 {
			mapsGroupProvv.append(createMap(withGroup: i))
		}
		let mapsGroup = mapsGroupProvv
		
		var debugCounter01 = 1
		for seedsRange in seedsRanges {
			print("Big loop \(debugCounter01) of \(seedsRanges.count)")
			
			var debugCounter02 = 1
			for seed in seedsRange {
				if debugCounter02 % 1_000_000 == 0 {
					print("Medium loop \(debugCounter02 / 1_000_000) of \(seedsRange.count / 1_000_000)")
				}
				
				var transformed = seed
				//			print("START: ", transformed)
				for maps in mapsGroup {
				mapsLoop:
					for map in maps {
						let sourceRange = map.sourceRangeStart..<(map.sourceRangeStart + map.rangeLength)
						if (sourceRange).contains(transformed) {
							transformed = transformed - (map.sourceRangeStart - map.destinationRangeStart)
							//						print("INRANGE: ", transformed)
							break mapsLoop
						} else {
							//						print("NOTINRANGE: ", transformed)
						}
					}
				}
				//			print("END: ", transformed)
				lowerLocation = (transformed > lowerLocation) ? lowerLocation : transformed
				
				debugCounter02 += 1
			}
			debugCounter01 += 1
		}
		
		return lowerLocation
	}
}

extension Day05 {
	private struct Map {
		let destinationRangeStart: Int
		let sourceRangeStart: Int
		let rangeLength: Int
	}
	
	private func createMap(withGroup groupNumber: Int) -> [Map] {
		var lines = entities[groupNumber].split(separator: "\n")
		lines.removeFirst()
		var maps: [Map] = []
		for line in lines {
			let map = line.split(separator: " ").map(String.init).compactMap(Int.init)
			maps.append(Map(destinationRangeStart: map[0], sourceRangeStart: map[1], rangeLength: map[2]))
		}
		return maps
	}
	
	private func transform(seed: Int, with mapsGroup: [[Map]]) async -> Int {
		var transformed = seed
		for maps in mapsGroup {
		mapsLoop:
			for map in maps {
				let sourceRange = map.sourceRangeStart..<(map.sourceRangeStart + map.rangeLength)
				if (sourceRange).contains(transformed) {
					transformed = transformed - (map.sourceRangeStart - map.destinationRangeStart)
					break mapsLoop
				}
			}
		}
		return transformed
	}
}
