//
//  UICollectionViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 11/12/2016.
//  Copyright © 2016 SwifterSwift
//

import UIKit
#if !os(watchOS)

fileprivate var collectionViewAutoScroll = 1
fileprivate var timerTest:Timer?

// MARK: - Properties
public extension UICollectionView{
   
    
    @objc func timer(){
        self.moveToNextItem()
    }
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func autoScrolling() {
        
        collectionViewAutoScroll = 1
        self.stopTimerTest()
        startTimer()
        //Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timer), userInfo: nil, repeats: true)
    }
    func startTimer () {
        
        if timerTest == nil {
            timerTest =  Timer.scheduledTimer(
                timeInterval: TimeInterval(2),
                target      : self,
                selector    : #selector(timer),
                userInfo    : nil,
                repeats     : true)
        }
    }
    
    func stopTimerTest() {
        if timerTest != nil {
            timerTest?.invalidate()
            timerTest = nil
        }
    }
    
    
    /// running auto scrolling
    ///
    /// - Parameter count: number of items
    func moveToNextItem() {
        let count = self.numberOfItems()
        if count > 0 {
            if collectionViewAutoScroll < count {
                let indexPath = IndexPath(item: collectionViewAutoScroll, section: 0)
                self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                collectionViewAutoScroll = collectionViewAutoScroll + 1
            } else {
                collectionViewAutoScroll = 1
                self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
        
        
    }
    

}

// MARK: - Properties
public extension UICollectionView {

	/// SwifterSwift: Index path of last item in collectionView.
    var indexPathForLastItem: IndexPath? {
		return indexPathForLastItem(inSection: lastSection)
	}

	/// SwifterSwift: Index of last section in collectionView.
    var lastSection: Int {
		return numberOfSections > 0 ? numberOfSections - 1 : 0
	}

}

// MARK: - Methods
public extension UICollectionView {

	/// SwifterSwift: Number of all items in all sections of collectionView.
	///
	/// - Returns: The count of all rows in the collectionView.
    func numberOfItems() -> Int {
		var section = 0
		var itemsCount = 0
		while section < self.numberOfSections {
			itemsCount += numberOfItems(inSection: section)
			section += 1
		}
		return itemsCount
	}

	/// SwifterSwift: IndexPath for last item in section.
	///
	/// - Parameter section: section to get last item in.
	/// - Returns: optional last indexPath for last item in section (if applicable).
    func indexPathForLastItem(inSection section: Int) -> IndexPath? {
		guard section >= 0 else {
			return nil
		}
		guard section < numberOfSections else {
			return nil
		}
		guard numberOfItems(inSection: section) > 0 else {
			return IndexPath(item: 0, section: section)
		}
		return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
	}

	/// SwifterSwift: Reload data with a completion handler.
	///
	/// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0, animations: {
			self.reloadData()
		}, completion: { _ in
			completion()
		})
	}

	/// SwifterSwift: Dequeue reusable UICollectionViewCell using class name.
	///
	/// - Parameters:
	///   - name: UICollectionViewCell type.
	///   - indexPath: location of cell in collectionView.
	/// - Returns: UICollectionViewCell object with associated class name.
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name))")
        }
        return cell
    }

	/// SwifterSwift: Dequeue reusable UICollectionReusableView using class name.
	///
	/// - Parameters:
	///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
	///   - name: UICollectionReusableView type.
	///   - indexPath: location of cell in collectionView.
	/// - Returns: UICollectionReusableView object with associated class name.
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: name))")
        }
		return cell
	}

	/// SwifterSwift: Register UICollectionReusableView using class name.
	///
	/// - Parameters:
	///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
	///   - name: UICollectionReusableView type.
    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
		register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
	}

	/// SwifterSwift: Register UICollectionViewCell using class name.
	///
	/// - Parameters:
	///   - nib: Nib file used to create the collectionView cell.
	///   - name: UICollectionViewCell type.
    func register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type) {
		register(nib, forCellWithReuseIdentifier: String(describing: name))
	}

	/// SwifterSwift: Register UICollectionViewCell using class name.
	///
	/// - Parameter name: UICollectionViewCell type.
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
		register(T.self, forCellWithReuseIdentifier: String(describing: name))
	}

	/// SwifterSwift: Register UICollectionReusableView using class name.
	///
	/// - Parameters:
	///   - nib: Nib file used to create the reusable view.
	///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
	///   - name: UICollectionReusableView type.
    func register<T: UICollectionReusableView>(nib: UINib?, forSupplementaryViewOfKind kind: String, withClass name: T.Type) {
		register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
	}

    /// SwifterSwift: Register UICollectionViewCell with .xib file using only its corresponding class.
    ///               Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameters:
    ///   - name: UICollectionViewCell type.
    ///   - bundleClass: Class in which the Bundle instance will be based on.
    func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle? = nil

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }

}
#endif


