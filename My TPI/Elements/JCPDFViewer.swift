//
//  JCPDFViewer.swift
//  My TPI
//
//  Created by Joshua Colley on 15/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit
import WebKit
import MessageUI

enum MIMEType: String {
    case pdf = "application/pdf"
}

class JCPDFViewer: UIViewController {

    @IBOutlet var webview: WKWebView!
    var inspection: ApplianceInspection!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Review"
        
        let RBB = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePDF))
        self.navigationItem.rightBarButtonItem = RBB
        
        let html = setupPageOne(inspection: self.inspection)
        self.webview.loadHTMLString(html, baseURL: nil)
//        getHTMLString(fileName: "index")
        
    }
    
    // MARK: - Get HTML String from file
    fileprivate func getHTMLString(fileName: String) -> String {
        let file = Bundle.main.path(forResource: fileName, ofType: "html")
        do {
            let contents = try String(contentsOfFile: file!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            // Replace Placeholders
            return contents
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        return ""
    }
    
    // MARK: - Create PDF
    @objc fileprivate func savePDF() {
        let A4Page = CGRect(x: 0, y: 0, width: 595.2, height: 841.0)
        let printRenderer = UIPrintPageRenderer()
        
        // Loop Start (to add)
        printRenderer.setValue(A4Page, forKey: "printableRect")
        printRenderer.setValue(A4Page, forKey: "paperRect")
        
        let markup = setupPageOne(inspection: self.inspection)
        let formatter = UIMarkupTextPrintFormatter(markupText: markup)
        printRenderer.addPrintFormatter(formatter, startingAtPageAt: 0)
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<printRenderer.numberOfPages {
            UIGraphicsBeginPDFPage();
            printRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        // Loop End (to add)
        
        UIGraphicsEndPDFContext();
        
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        
        pdfData.write(to: outputURL, atomically: true)
        print("open \(outputURL.path)") // command to open the generated file
        showMailComposer(attachmentFilepath: outputURL.path)
    }
    
    // MARK: - Email PDF
    func showMailComposer(attachmentFilepath: String) {
        if MFMailComposeViewController.canSendMail() {
            let subject = "Subject Text"
            let message = "Message Goes Here."
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setSubject(subject)
            mailComposer.setMessageBody(message, isHTML: false)
            
            do {
                let pdfData = try Data(contentsOf: URL(fileURLWithPath: attachmentFilepath))
                mailComposer.addAttachmentData(pdfData, mimeType: MIMEType.pdf.rawValue, fileName: "Certificate")
                self.present(mailComposer, animated: true, completion: nil)
            } catch {
                return
            }
        }
    }
    
    fileprivate func setupPageOne(inspection: ApplianceInspection) -> String {
        var htmlString = getHTMLString(fileName: "index")
        htmlString = htmlString.replacingOccurrences(of: "@%INSPECTIONTYPE", with: inspection.inspectionType ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%CERTNO", with: inspection.inspectionNumber ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%TIMESHEET", with: inspection.timesheetRef ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LOCATION", with: inspection.location ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LASTEXAMDATE", with: inspection.previousExamDate ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LASTTESTDATE", with: inspection.previousTestDate ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%DATE", with: inspection.dateOfInspection ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%ISSUEDATE", with: Date().displayString())
        htmlString = htmlString.replacingOccurrences(of: "@%STANDARD", with: inspection.standards ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LASTEXAMCERT", with: inspection.previousExamCert ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LASTTESTCERT", with: inspection.previousTestCert ?? "")
        
        // Funky stuff to refactor
        let client = "\(inspection.clientName ?? ""), \(inspection.clientAddress ?? "")"
        htmlString = htmlString.replacingOccurrences(of: "@%CLIENTDETAILS", with: client)
        
        return htmlString
    }
}

extension JCPDFViewer: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue: debugPrint("Cancelled")
        case MFMailComposeResult.sent.rawValue: debugPrint("Sent")
        case MFMailComposeResult.saved.rawValue: debugPrint("Saved")
        case MFMailComposeResult.failed.rawValue: debugPrint("Failed")
        default:break
        }
        dismiss(animated: true, completion: nil)
    }
}
