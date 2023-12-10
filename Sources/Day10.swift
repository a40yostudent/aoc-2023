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
		var pipes = [[Pipe]]()
		var startPipe: Pipe?
		
		let pipesArray = entities.map({$0.map(String.init)})/*.compactMap({ Pipe(rawValue: $0)})})*/
		for (y, pipesLine) in pipesArray.enumerated() {
			var pipeLine = [Pipe]()
			for (x, pipeChar) in pipesLine.enumerated() {
				let pipe = Pipe(type: PipeType(rawValue: pipeChar)!, x: x, y: y)
				pipeLine.append(pipe)
				if pipe.type == ._s {
					startPipe = pipe
				}
			}
			pipes.append(pipeLine)
		}
		
		guard let startPipe else { fatalError("start pipe not found") }
		
		print(pipes.debugDescription, startPipe)
		
		return 0
	}
	
	// Replace this with your solution for the second part of the day's challenge.
	func part2() -> Any {
		return 0
	}
}

extension Day10 {
	fileprivate enum PipeType: String {
		case _v = "|", _h = "-", _l = "L", _j = "J", _7 = "7", _f = "F", _g = ".", _s = "S"
	}
	
	fileprivate struct Pipe {
		let type: PipeType
		let x: Int
		let y: Int
	}
}

extension Day10.PipeType: CustomDebugStringConvertible {
	var debugDescription: String {
		return self.rawValue
	}
}

extension Day10.Pipe: CustomDebugStringConvertible {
	var debugDescription: String {
		return "\(self.type.debugDescription), x: \(self.x.description), y: \(self.y.description)"
	}
}
