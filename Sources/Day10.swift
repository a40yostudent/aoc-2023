import Algorithms

struct Day10: AdventDay {

	// Save your data in a corresponding text file in the `Data` directory.
	let data: String
	
	let map: [[Character]]
	fileprivate let adj: [Position: (Position, Position)]
	fileprivate let start: Position
		
	init(data: String) {
		// data
		self.data = data
		
		// map
		let lines = data.split(separator: "\n")
		var map: [[Character]] = []
		for line in lines {
			var newLine = [Character]()
			for char in line {
				newLine.append(char)
			}
			map.append(newLine)
		}
		
		// adj and start
		var adj: [Position: (Position, Position)] = [:]
		var start: Position?
		var startChar: Character?
		
		for (y, mapLine) in map.enumerated() {
			for (x, char) in mapLine.enumerated() {
				let current = Position(x: x, y: y)
				switch char /*map[y][x]*/ {
					case "|":
						adj[current] = (current.up, current.down)
					case "-":
						adj[current] = (current.left, current.right)
					case "L":
						adj[current] = (current.up, current.right)
					case "J":
						adj[current] = (current.left, current.up)
					case "7":
						adj[current] = (current.left, current.down)
					case "F":
						adj[current] = (current.down, current.right)
					case "S":
						start = current
						var sAdj = [Position]()
						if current.right.char(in: map) == "-" ||
							current.right.char(in: map) == "7" ||
							current.right.char(in: map) == "J" {
							sAdj.append(current.right)
						}
						if current.left.char(in: map) == "-" ||
							current.left.char(in: map) == "F" ||
							current.left.char(in: map) == "L" {
							sAdj.append(current.left)
						}
						if current.up.char(in: map) == "|" ||
							current.up.char(in: map) == "7" ||
							current.up.char(in: map) == "F" {
							sAdj.append(current.up)
						}
						if current.down.char(in: map) == "|" ||
							current.down.char(in: map) == "L" ||
							current.down.char(in: map) == "J" {
							sAdj.append(current.down)
						}
						if sAdj.contains(current.right) &&
							sAdj.contains(current.up) {
							startChar = "L"
							adj[current] = (current.up, current.right)
						} else
						if sAdj.contains(current.right) &&
							sAdj.contains(current.down){
							startChar = "F"
							adj[current] = (current.down, current.right)
						} else
						if sAdj.contains(current.right) &&
							sAdj.contains(current.left){
							startChar = "-"
							adj[current] = (current.left, current.right)
						} else
						if sAdj.contains(current.left) &&
							sAdj.contains(current.up){
							startChar = "J"
							adj[current] = (current.up, current.left)
						} else
						if sAdj.contains(current.left) &&
							sAdj.contains(current.down){
							startChar = "7"
							adj[current] = (current.down, current.left)
						} else
						if sAdj.contains(current.up) &&
							sAdj.contains(current.down){
							startChar = "|"
							adj[current] = (current.down, current.up)
						} else {
							fatalError("adjacency error around start position")
						}
					default:
						continue // "."
				}
			}
		}
		guard let start, let startChar else { fatalError("start node not found") }
		map[start.y][start.x] = startChar
		self.adj = adj
		self.map = map
		self.start = start
	}
	
	// takes a lot of time...
	func part1() -> Any {
		var steps = 1
		var currentNode = start
		var nextNode = adj[currentNode]!.0
		while nextNode != start {
			steps += 1
			guard let nextAdj = adj[nextNode] else { fatalError("next node adjacency") }
			let temp = nextNode
			if nextAdj.0 == currentNode {
				nextNode = nextAdj.1
			} else {
				nextNode = nextAdj.0
			}
			currentNode = temp
		}
		return steps / 2
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		// make a clean map
		var cleanMap = Array(repeating: Array(repeating: Character("."), count: map[0].count), count: map.count)
		cleanMap[start.y][start.x] = map[start.y][start.x]
		var currentNode = start
		var nextNode = adj[currentNode]!.0
		while nextNode != start {
			cleanMap[nextNode.y][nextNode.x] = map[nextNode.y][nextNode.x]
			guard let nextAdj = adj[nextNode] else { fatalError("next node adjacency") }
			let temp = nextNode
			if nextAdj.0 == currentNode {
				nextNode = nextAdj.1
			} else {
				nextNode = nextAdj.0
			}
			currentNode = temp
		}
		
		var debugMap = cleanMap // debug
		var count = 0
		for (y, line) in cleanMap.enumerated() {
			var inside = false
			var lastWasAnF = false
			var lastWasAnL = false
			for (x, char) in line.enumerated() {
				switch char {
					case "|":
						inside.toggle()
					case "F":
						lastWasAnF = true
					case "L":
						lastWasAnL = true
					case "7":
						if lastWasAnL {
							inside.toggle()
							lastWasAnL = false
						}
						lastWasAnF = false
					case "J":
						if lastWasAnF {
							inside.toggle()
							lastWasAnF = false
						}
						lastWasAnL = false
					case ".":
						if inside {
							count += 1
							debugMap[y][x] = "I"
						} else {
							debugMap[y][x] = "O"
						}
					case "-":
						continue
					default:
						fatalError("char not recognized")
				}
			}
		}
		
		// pretty printed map
		var prettyMap = [[Character]]()
		for line in debugMap {
			var newLine = [Character]()
			for char in line {
				switch char {
					case "F":
						newLine.append("┌")
					case "-":
						newLine.append("─")
					case "7":
						newLine.append("┐")
					case "|":
						newLine.append("│")
					case "L":
						newLine.append("└")
					case "J":
						newLine.append("┘")
					case ".":
						newLine.append(".")
					case "I":
						newLine.append("I")
					case "O":
						newLine.append("O")
					default:
						continue
				}
			}
			prettyMap.append(newLine)
		}
		
		print("\n")
		for line in prettyMap {
			print(String(line))
		}
		return count
	}
		
}

extension Day10 {
	
	fileprivate struct Position: Hashable, CustomDebugStringConvertible {
		
		let x: Int
		let y: Int
		
		var up: Position {
			return Position(x: x, y: y-1)
		}
		
		var down: Position {
			return Position(x: x, y: y+1)
		}
		
		var left: Position {
			return Position(x: x-1, y: y)
		}
		
		var right: Position {
			return Position(x: x+1, y: y)
		}
		
		func char(in map: [[Character]]) -> Character? {
			guard self.x > -1 && self.y > -1 else {
				return nil
			}
			
			return map[self.y][self.x]
		}
		
		var debugDescription: String {
			"x: \(x), y: \(y)"
		}
	}
}
