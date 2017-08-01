//
//  ViewController.swift
//  RichTextEditor
//
//  Created by mark on 7/18/17.
//  Copyright © 2017 Me and Mark Publishing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var textView: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear() {
        // Fill the text view with the document's contents.
        let document = self.view.window?.windowController?.document as! Document
        textView.textStorage?.setAttributedString(document.text)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

