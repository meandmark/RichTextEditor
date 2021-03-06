//
//  Document.swift
//  RichTextEditor
//
//  Created by mark on 7/18/17.
//  Copyright © 2017 Me and Mark Publishing. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    var text = NSAttributedString()
    
    var viewController: ViewController? {
        return windowControllers[0].contentViewController as? ViewController
    }
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidMiniaturize(aNotification:)), name: NSWindow.didMiniaturizeNotification, object: nil)
    }

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        
        // Save the text view contents to disk
        if let textView = viewController?.textView {
            let rangeLength = textView.string.count
            
            textView.breakUndoCoalescing()
            let textRange = NSRange(location: 0, length: rangeLength)
            if let contents = textView.rtf(from: textRange) {
                return contents
            }
        }
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        
        if let contents = NSAttributedString(rtf: data, documentAttributes: nil) {
            text = contents
        }
    }

    @objc func windowDidMiniaturize(aNotification: Notification) {
        saveText()
    }
    
    func saveText() {
        if let textView = viewController?.textView {
            text = textView.attributedString()
        }
    }
}

