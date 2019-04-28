//
//  ViewController.swift
//  J2OBJCBase
//

import UIKit

// UIViewController that shows a board of 10x10 cells of Game of Life implementation.
class ViewController: UIViewController, GofCoreDisplayDriver {
    
    /// The board is square. This defines the edge size of the board (10 x 10)
    private let boardSize: Int = 10
    /// The board logic
    private var board: GofCoreBoard!
    /// A timer to update the board periodically
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the board with 30% change of a cell to be alive
        board = GofCoreBoard(int: jint(boardSize), with: jint(boardSize), with: 0.3)
        
        // Create a grid of 10 UIStackView where each has 10 UIView inside of a 30pt x 30pt size
        var _grid: [UIStackView] = []
        for _ in 0..<boardSize {
            var _row: [UIView] = []
            for _ in 0..<boardSize {
                // Create a cell of 30 x 30 pt size
                let cell = UIView(frame: .zero)
                cell.translatesAutoresizingMaskIntoConstraints = false
                cell.heightAnchor.constraint(equalToConstant: 30).isActive = true
                cell.widthAnchor.constraint(equalToConstant: 30).isActive = true
                _row.append(cell)
            }
            // Add all the cells to a row
            let row = UIStackView(arrangedSubviews: _row)
            row.axis = .horizontal
            // Add the row to the grid
            _grid.append(row)
        }
        let grid = UIStackView(arrangedSubviews: _grid)
        grid.axis = .vertical
        grid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(grid)
        // place the grid in the center
        grid.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        grid.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Update the display of the board
        displayBoard(with: board)
        // Schedule a timer for every 2 seconds to update the board
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] (_) in
            guard let self = self else {
                return
            }
            // Update the board and render it
            self.board.update()
            self.displayBoard(with: self.board)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop the timer when the view is no longer visible
        timer?.invalidate()
    }
    
    // Implemented as part of the protocol GofCoreDisplayDriver
    func displayBoard(with board: GofCoreBoard!) {
        guard let grid = board.getGrid() else {
            return
        }
        // Loop through all cells and update the state of the corresponding UIView
        for (rIndex, _row) in grid.enumerated() {
            let row = _row as! IOSObjectArray
            for (cIndex, _cell) in row.enumerated() {
                let cell = _cell as! GofCoreCell
                let cellView = ((view.subviews[0] as! UIStackView).arrangedSubviews[rIndex] as! UIStackView).arrangedSubviews[cIndex]
                // If cell is dead, color background black. Otherwise color background in red
                cellView.backgroundColor = cell.getState() ? UIColor.red : UIColor.black
            }
        }
    }
    
}

/// Allows the usage of IOSObjectArray in Swift for in
extension IOSObjectArray: Sequence {
    public func makeIterator() -> NSFastEnumerationIterator {
        return NSFastEnumerationIterator(self)
    }
}

