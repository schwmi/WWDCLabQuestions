//
//  Document.swift
//  PrintInfoHang
//
//  Created by Michael Schwarz on 02.06.19.
//  Copyright © 2019 IdeasOnCanvas GmbH. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class var autosavesInPlace: Bool {
        return true
    }

    override var windowNibName: NSNib.Name? {
        return NSNib.Name("Document")
    }

    override func data(ofType typeName: String) throws -> Data {
        Swift.print("write")
        return Data()
    }

    override func read(from data: Data, ofType typeName: String) throws {
        Swift.print("Read")
    }

    @IBAction func readPrintInfo(_ sender: Any) {
        let printInfo = self.printInfo.dictionary

        Swift.print("Finish read \(printInfo)")
    }
}

