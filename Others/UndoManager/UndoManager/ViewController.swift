//
//  ViewController.swift
//  UndoManager
//
//  Created by LuoLiu on 16/10/24.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var btnAddRect: UIButton!
    @IBOutlet weak var btnUndo: UIButton!
    @IBOutlet weak var btnRedo: UIButton!
    
    private var figures = [FigureView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeUndoManager()
        updateUndoAndRedoButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Undo Manager
    private var _undoManager = UndoManager()
    override var undoManager: UndoManager {
        return _undoManager
    }

    // MARK: - Notification
    private func observeUndoManager() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUndoAndRedoButtons), name:.NSUndoManagerDidUndoChange, object: undoManager)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUndoAndRedoButtons), name: .NSUndoManagerDidRedoChange, object: undoManager)
    }
    
    @objc private func updateUndoAndRedoButtons() {
        // Undo Button
        btnUndo.isEnabled = undoManager.canUndo == true
        if undoManager.canUndo {
            btnUndo.setTitle(undoManager.undoMenuTitle(forUndoActionName: undoManager.undoActionName), for: .normal)
        } else {
            btnUndo.setTitle(undoManager.undoMenuItemTitle, for: .normal)
        }
        
        // Redo Button
        btnRedo.isEnabled = undoManager.canRedo == true
        if undoManager.canRedo {
            btnRedo.setTitle(undoManager.redoMenuTitle(forUndoActionName: undoManager.redoActionName), for: .normal)
        } else {
            btnRedo.setTitle(undoManager.redoMenuItemTitle, for: .normal)
        }
    }
    
    // MARK: - Button Method
    @IBAction func addRectangleTapped(_ sender: AnyObject) {
        let rect = CGRect(x: view.center.x-50, y: view.center.y-50, width: 100, height: 100)
        let figureView = FigureView(frame: rect)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleFigureLongPressGesture(recognizer:)))
        longPressGesture.minimumPressDuration = 0.25
        figureView.addGestureRecognizer(longPressGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapGesture(recognizer:)))
        doubleTapGesture.numberOfTapsRequired = 2
        figureView.addGestureRecognizer(doubleTapGesture)
        
        addFigureView(figure: figureView)
    }
    
    // MARK: - FigureView Actions
    @objc private func addFigureView(figure: FigureView) {
        registerUndoAddFigure(on: figure)
        
        boardView.addSubview(figure)
        figures.append(figure)
        
        updateUndoAndRedoButtons()
    }
    
    @objc private func removeFigureView(figure: FigureView) {
        registerUndoRemoveFigure(on: figure)
        
        figure.removeFromSuperview()
        if let index = figures.index(of: figure) {
            figures.remove(at: index)
        }
    }
    
    @objc private func moveFigureView(dic: [String: Any]) {
        let figure = dic["figure"] as! FigureView
        registerUndoMoveFigure(on: figure)
        figure.center = dic["center"] as! CGPoint
    }
    
//    @objc private func moveFigureView2(figure: FigureView, center: CGPoint) {
//        registerUndoMoveFigure(on: figure)
//        figure.center = center
//    }
    
    // MARK: - Undo Manager Actions
    private func registerUndoAddFigure(on figureView: FigureView) {
        undoManager.registerUndo(withTarget: self, selector: #selector(removeFigureView(figure:)), object: figureView)
        undoManager.setActionName("Add Figure")
    }
    
    private func registerUndoRemoveFigure(on figureView: FigureView) {
        undoManager.registerUndo(withTarget: self, selector: #selector(addFigureView(figure:)), object: figureView)
        undoManager.setActionName("Remove Figure")
    }
    
    private func registerUndoMoveFigure(on figureView: FigureView) {
//        undoManager.registerUndo(withTarget: self) { targetSelf in
//            // 这样写不行，获取不到移动前的figureView
//            targetSelf.moveFigureView2(figure: figureView, center: figureView.center)
//        }
        undoManager.registerUndo(withTarget: self, selector: #selector(moveFigureView(dic:)), object: ["figure":figureView,"center":figureView.center])
        let center = String(format: "%.1f, %.1f", figureView.center.x, figureView.center.y)
        undoManager.setActionName("Move to (\(center))")
    }
    
    // MARK: - Gesture Recognizer
    @objc private func handleFigureLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        let figure = recognizer.view as! FigureView
        switch recognizer.state {
        case .began:
            registerUndoMoveFigure(on: figure)
            grabFigure(figure: figure, gesture: recognizer)
        case .changed:
            moveFigure(figure: figure, gesture: recognizer)
        case .ended:
            dropFigure(figure: figure, gesture: recognizer)
            updateUndoAndRedoButtons()
        case .cancelled:
            dropFigure(figure: figure, gesture: recognizer)
        default:
            break
        }
    }
    
    @objc private func handleDoubleTapGesture(recognizer: UITapGestureRecognizer) {
        print("Double Tap")
        // TODO:
    }
    
    private func grabFigure(figure: FigureView, gesture: UIGestureRecognizer) {
        UIView.animate(withDuration: 0.2) { 
            figure.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            figure.alpha = 0.8
        }

        moveFigure(figure: figure, gesture: gesture)
    }
    
    private func moveFigure(figure: FigureView, gesture: UIGestureRecognizer) {
        figure.center = gesture.location(in: self.view)
    }
    
    private func dropFigure(figure: FigureView, gesture: UIGestureRecognizer) {
        UIView.animate(withDuration: 0.2) {
            figure.transform = CGAffineTransform.identity
            figure.alpha = 1.0
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}

