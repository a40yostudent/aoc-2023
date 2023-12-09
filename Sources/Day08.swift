import Algorithms

struct Day08: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: ([String], [String : (String, String)]) {
		let firstSplit = data.split(separator: "\n\n")
		let leftRight = firstSplit[0].map(String.init)
		let nodesLines = firstSplit[1]
		let secondSplit = nodesLines.split(separator: "\n")
		var nodes: [String : (String, String)] = [:]
		for line in secondSplit {
			let thirdSplit = line.split(separator: " = ")
			let key = thirdSplit[0]
			let fourthSplit = thirdSplit[1].dropFirst().dropLast().split(separator: ", ")
			let left = fourthSplit[0]
			let right = fourthSplit[1]
			nodes[String(key)] = (String(left), String(right))
		}
		
		return (leftRight, nodes)
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		let leftRight = entities.0
		let nodes = entities.1
		
		var steps = 0
		var index = 0
		var currentKey = "AAA"
		
		while currentKey != "ZZZ" {
			guard let currentNode = nodes[currentKey] else { fatalError() }
			switch leftRight[index] {
				case "L":
					currentKey = currentNode.0
				case "R":
					currentKey = currentNode.1
				default:
					fatalError()
			}
			if (index + 1) < leftRight.count {
				index += 1
			} else {
				index = 0
			}
			
			steps += 1
		}

		return steps // 11309
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		let leftRight = entities.0
		let nodes = entities.1
		let startKeys = nodes.filter{ $0.key.hasSuffix("A") }.map{$0.key}
		
		var steps: [Int] = []

		for key in startKeys {
			var partialSteps = 0
			var index = 0
			var currentKey = key
			
			while !currentKey.hasSuffix("Z") {
				guard let currentNode = nodes[currentKey] else { fatalError() }
				switch leftRight[index] {
					case "L":
						currentKey = currentNode.0
					case "R":
						currentKey = currentNode.1
					default:
						fatalError()
				}
				if (index + 1) < leftRight.count {
					index += 1
				} else {
					index = 0
				}
				
				partialSteps += 1
			}
			
			steps.append(partialSteps)
		}
		
		let gcd = steps.reduce(steps[0], gcd)
		let lcm = steps.map{$0 / gcd}.reduce(1, *) * gcd
		return lcm // 13.740.108.158.591
	}
}

extension Day08 {
	private func gcd(_ a: Int, _ b: Int) -> Int {
		if a == b {
			return a
		} else if a > b {
			return gcd(a - b, b)
		} else {
			return gcd(a, b - a)
		}
	}
}
