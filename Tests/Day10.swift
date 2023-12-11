import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day10Tests: XCTestCase {
	// Smoke test data provided in the challenge question
	let testData = ("""
	-L|F7
	7S-7|
	L|7||
	-L-J|
	L|-JF
	""",
	"""
	7-F7-
	.FJ|7
	SJLL7
	|F--J
	LJ.LJ
	""") // 4, 8
	
	func testPart1() throws {
		let challenge0 = Day10(data: testData.0)
		XCTAssertEqual(String(describing: challenge0.part1()), "4")
		
		let challenge1 = Day10(data: testData.1)
		XCTAssertEqual(String(describing: challenge1.part1()), "8")
	}
	
	func testPart2() throws {
		let challenge0 = Day10(data: testData.0)
		XCTAssertEqual(String(describing: challenge0.part2()), "0")
		
		let challenge1 = Day10(data: testData.1)
		XCTAssertEqual(String(describing: challenge1.part1()), "0")
	}
}
