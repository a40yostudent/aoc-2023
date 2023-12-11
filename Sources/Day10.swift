import Algorithms

struct Day10: AdventDay {
	// Save your data in a corresponding text file in the `Data` directory.
	var data: String
	
	// Splits input data into its component parts and convert from string.
	var entities: [[Character]] {
		var entities = [[Character]]()
		let lines = data.split(separator: "\n")
		for line in lines {
			var chars = [Character]()
			for char in line {
				chars.append(char)
			}
			entities.append(chars)
		}
		return entities
	}
	
	// Replace this with your solution for the first part of the day's challenge.
	func part1() -> Any {
		// A node is defined as it follows: yPosition * 1000 + xPosition
		
		var adjacencyList: [Int: (Int, Int)] = [:]
		var sNode: Int?
		
		for (y, line) in entities.enumerated() {
			for (x, char) in line.enumerated() {
				let position = y * 1000 + x
				
				switch char {
					case "|":
						adjacencyList[position] = (position - 1000, position + 1000)
					case "-":
						adjacencyList[position] = (position - 1, position + 1)
					case "L":
						adjacencyList[position] = (position - 1000, position + 1)
					case "J":
						adjacencyList[position] = (position - 1000, position - 1)
					case "7":
						adjacencyList[position] = (position - 1, position + 1000)
					case "F":
						adjacencyList[position] = (position + 1, position + 1000)
					case "S":
						sNode = position
					default:
						continue // "."
				}
			}
		}
		
		guard let sNode else { fatalError("starting node not found") }

		if entities[sNode / 1000][sNode % 1000] == "S" {
			print("sNode found")
		} else {
			print(entities[sNode / 1000][sNode % 1000], " found at: ", (sNode % 1000), (sNode / 1000))
		}
		
		// Traversing the pipes
		var steps = 0
		var prevNode = sNode
		var currentNode = -1
		
		// Find first node after sNode, because sNode has no visibl edges. I know it will pass the 2nd test.
		if entities[sNode / 1000][sNode % 1000 + 1] == "7" ||
			entities[sNode / 1000][sNode % 1000 + 1] == "J" {
			currentNode = sNode + 1
			steps += 1
		} else if entities[sNode / 1000][sNode % 1000 - 1] == "F" ||
					entities[sNode / 1000][sNode % 1000 - 1] == "L" {
			currentNode = sNode - 1
			steps += 1
		}
		
		while currentNode != sNode {
			guard let nextNode = adjacencyList[currentNode] else {
				fatalError("next node not found on adjacency list")
			}
			if nextNode.0 != prevNode {
				prevNode = currentNode
				currentNode = nextNode.0
				steps += 1
			} else {
				prevNode = currentNode
				currentNode = nextNode.1
				steps += 1
			}
		}
		
		
		return steps / 2
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		// A node is defined as it follows: yPosition * 1000 + xPosition
		
		var adjacencyList: [Int: (Int, Int)] = [:]
		var sNode: Int?
		
		for (y, line) in entities.enumerated() {
			for (x, char) in line.enumerated() {
				let position = y * 1000 + x
				
				switch char {
					case "|":
						adjacencyList[position] = (position - 1000, position + 1000)
					case "-":
						adjacencyList[position] = (position - 1, position + 1)
					case "L":
						adjacencyList[position] = (position - 1000, position + 1)
					case "J":
						adjacencyList[position] = (position - 1000, position - 1)
					case "7":
						adjacencyList[position] = (position - 1, position + 1000)
					case "F":
						adjacencyList[position] = (position + 1, position + 1000)
					case "S":
						sNode = position
					default:
						continue // "."
				}
			}
		}
		
		guard let sNode else { fatalError("starting node not found") }
		
		if entities[sNode / 1000][sNode % 1000] == "S" {
			print("sNode found")
		} else {
			print(entities[sNode / 1000][sNode % 1000], " found at: ", (sNode % 1000), (sNode / 1000))
		}
		
		// Traversing the pipes
		var steps = 0
		var prevNode = sNode
		var currentNode = -1
		
		// Save pipes that are on the main track
		var mainPipe = [Int]()
		
		// Find first node after sNode, because sNode has no visibl edges. I know it will pass the 2nd test.
		if entities[sNode / 1000][sNode % 1000 + 1] == "7" ||
			entities[sNode / 1000][sNode % 1000 + 1] == "J" {
			currentNode = sNode + 1
			steps += 1
		} else if entities[sNode / 1000][sNode % 1000 - 1] == "F" ||
					entities[sNode / 1000][sNode % 1000 - 1] == "L" {
			currentNode = sNode - 1
			steps += 1
		}
		
		while currentNode != sNode {
			guard let nextNode = adjacencyList[currentNode] else {
				fatalError("next node not found on adjacency list")
			}
			mainPipe.append(currentNode)
			
			if nextNode.0 != prevNode {
				prevNode = currentNode
				currentNode = nextNode.0
				steps += 1
			} else {
				prevNode = currentNode
				currentNode = nextNode.1
				steps += 1
			}
		}
		
		// create a new empty map
		var map = [[Character]]()
		for y in 0..<140 {
			var line = [Character]()
			for x in 0..<140 {
				if (mainPipe.firstIndex(of: y * 1000 + x) != nil) {
					line.append("O")
				} else {
					line.append(".")
				}
			}
			map.append(line)
		}
		
		// print the map
		for line in map {
			print(String(line))
		}
		
		// and now I don't know what to do
		
		return steps / 2
	}
}
