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
    
    var page1: String = """
<div style="width: 596px; height: 841.0px; background: yellow">
    <h1 style="margin-top: 50px;">CERTIFICATE</h1>
    <h3 style="margin-top: 5px;">of Thorough Examination of Lifting Appliance</h3>
    
    <table style="width:calc(100% - 50px); margin: 15px 35px 0 25px; font-size: 14px;">
    <tbody style="width: 100%">
    <tr>
    <th colspan="3">Certificate No.:</th>
    <td colspan="3"></td>
    <th colspan="3">Examination Date:</th>
    <td colspan="3"></td>
    </tr>
    <tr>
    <th colspan="6">Client:</th>
    <th colspan="3">Location:</th>
    <th colspan="3">Standard:</th>
    </tr>
    <tr>
    <td colspan="6"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="6"></td>
    <th colspan="3">Make &amp; Year: </th>
    <th colspan="3">Capacity:</th>
    </tr>
    <tr>
    <td colspan="6"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <th colspan="3">Reg. No.:</th>
    <th colspan="3">Fleet No.:</th>
    <th colspan="3">Serial No.:</th>
    <th colspan="3">Model No.:</th>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <th colspan="4">Lifting Appliance Description:</th>
    <td colspan="8"></td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="12">Details of Test &amp; Examination Carried Out</td>
    </tr>
    <tr>
    <th colspan="6">First Exam/Test after Installation/Assembly</th>
    <td colspan="2"></td>
    <td colspan="2"></td>
    <td colspan="2"></td>
    </tr>
    <tr>
    <th colspan="6">Was the Equipment Installed Correctly</th>
    <td colspan="2"></td>
    <td colspan="2"></td>
    <td colspan="2"></td>
    </tr>
    <tr>
    <th colspan="6">Thorough Examination: Full Functional Test with No Load</th>
    <td colspan="2"></td>
    <td colspan="2"></td>
    <td colspan="2"></td>
    </tr>
    <tr>
    <th colspan="6">Thorough Examination: Full Functional Test with SWL</th>
    <td colspan="2"></td>
    <td colspan="2"></td>
    <td colspan="2"></td>
    </tr>
    <tr>
    <th colspan="6">Proof Load Test Carried Out</th>
    <td colspan="2"></td>
    <td colspan="2"></td>
    <td colspan="2"></td>
    </tr>
    <tr>
    <th colspan="6">Reason for Examination</th>
    <td colspan="6"></td>
    </tr>
    <tr>
    <td colspan="12">Load Test Applied (Forth Row for Auxiliary Hoist if Applicable)</td>
    </tr>
    <tr>
    <td colspan="3">SWL</td>
    <td colspan="3">Applied Load</td>
    <td colspan="3">Boom Length</td>
    <td colspan="3">Radius</td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <th colspan="4">Additional Test Information:</th>
    <td colspan="8"></td>
    </tr>
    <tr>
    <th colspan="12">Defects Found: </th>
    </tr>
    <tr>
    <td colspan="12"></td>
    </tr>
    <tr>
    <th colspan="6">Are the defects above of immediate danger to persons:</th>
    <td colspan="6"></td>
    </tr>
    <tr>
    <th colspan="12">Recommendations Given: </th>
    </tr>
    <tr>
    <td colspan="12"></td>
    </tr>
    <tr>
    <th colspan="6">Result of Examination:</th>
    <td colspan="6"></td>
    </tr>
    <tr>
    <td colspan="3">Date of Late Examination</td>
    <td colspan="3">Date of Next Examination</td>
    <td colspan="3">Date of Last Load Test</td>
    <td colspan="3">Date of Next Load Test</td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    <td colspan="3"></td>
    </tr>
    <tr>
    <th colspan="3">Timesheet: </th>
    <td colspan="3"></td>
    <th colspan="3">Issue Date: </th>
    <td colspan="3"></td>
    </tr>
    </tbody>
    </table>
    </div>
"""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Review"
        
        let RBB = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePDF))
        self.navigationItem.rightBarButtonItem = RBB
        
        self.webview.loadHTMLString(getHTMLString(fileName: "index"), baseURL: nil)
        
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
        
        let formatter = UIMarkupTextPrintFormatter(markupText: getHTMLString(fileName: "index"))
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
