//
//  CollectionExtensions.swift
//  SwifterSwift
//
//  Created by Sergey Fedortsov on 19.12.16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Methods
public extension Collection {

	/// SwifterSwift: Performs `each` closure for each element of collection in parallel.
	///
	///		array.forEachInParallel { item in
	///			print(item)
	///		}
	///
	/// - Parameter each: closure to run for each element.
	/// SwifterSwift: Safe protects the array from out of bounds by use of optional.
	///
	///		let arr = [1, 2, 3, 4, 5]
	///		arr[safe: 1] -> 2
	///		arr[safe: 10] -> nil
	///
	/// - Parameter index: index of element to access element.
    subscript(safe index: Index) -> Iterator.Element? {
		return indices.contains(index) ? self[index] : nil
	}

}

// MARK: - Methods (Integer)
public extension Collection where Iterator.Element == IntegerLiteralType, Index == Int {

	/// SwifterSwift: Average of all elements in array.
	///
	/// - Returns: the average of the array's elements.
    func average() -> Double {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
	}

}
