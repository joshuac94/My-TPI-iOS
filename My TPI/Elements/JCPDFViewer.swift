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
        
        htmlString = htmlString.replacingOccurrences(of: "@%DESCRIPTION", with: inspection.equipmentDescription ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%REGNO", with: inspection.registration ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%FLEET", with: inspection.fleetNumber ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%SERIAL", with: inspection.serialNumber ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%MODEL", with: inspection.model ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%MAKE", with: inspection.make ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%SWL", with: inspection.capacity ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%HOURS", with: inspection.workingHours ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%MILEAGE", with: inspection.mileageReading ?? "")
        
        htmlString = htmlString.replacingOccurrences(of: "@%REASON", with: inspection.reasonForInspection ?? "")
        
        htmlString = htmlString.replacingOccurrences(of: "@%SWL1", with: inspection.swl1 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%SWL2", with: inspection.swl2 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%SWL3", with: inspection.swl3 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%SWL4", with: inspection.swl4 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LOAD1", with: inspection.appliedLoad1 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LOAD2", with: inspection.appliedLoad2 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LOAD3", with: inspection.appliedLoad3 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%LOAD4", with: inspection.appliedLoad4 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%BOOM1", with: inspection.boomLength1 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%BOOM2", with: inspection.boomLength2 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%BOOM3", with: inspection.boomLength3 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%BOOM4", with: inspection.boomLength4 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%RADIUS1", with: inspection.radius1 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%RADIUS2", with: inspection.radius2 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%RADIUS3", with: inspection.radius3 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%RADIUS4", with: inspection.radius4 ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%EXTRAINFO", with: inspection.testingInfo ?? "")
        
        htmlString = htmlString.replacingOccurrences(of: "@%DEFECTS", with: inspection.overallDefects ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%RECOMMENDATIONS", with: inspection.recommendations ?? "")
        
        htmlString = htmlString.replacingOccurrences(of: "@%RESULT", with: inspection.inspecionOutcome?.uppercased() ?? "")
        
        htmlString = htmlString.replacingOccurrences(of: "@%NEXTEXAM", with: inspection.nextExam ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%NEXTTEST", with: inspection.nextTest ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%INSPECTOR", with: inspection.inspectorsName ?? "")
        
        // Funky stuff to refactor
        let client = "\(inspection.clientName ?? ""), \(inspection.clientAddress ?? "")"
        htmlString = htmlString.replacingOccurrences(of: "@%CLIENTDETAILS", with: client)
        
        let info1 = detailsAnswer(answer: inspection.isFirstTest ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%YES1", with: info1["Yes"] ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%NA1", with: info1["NA"] ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%NO1", with: info1["No"] ?? "")
        
        let info2 = detailsAnswer(answer: inspection.isInstalledCorrectly ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%YES2", with: info2["Yes"] ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%NA2", with: info2["NA"] ?? "")
        htmlString = htmlString.replacingOccurrences(of: "@%NO2", with: info2["No"] ?? "")
        
        return htmlString
    }
    
    fileprivate func detailsAnswer(answer: String) -> [String: String] {
        var dict: [String: String] = [:]
        
        switch answer {
        case "Yes": dict = ["Yes": "Yes", "NA": "-", "No": "-"]
        case "Not Applicable": dict = ["Yes": "-", "NA": "Not Applicable", "No": "-"]
        case "No": dict = ["Yes": "-", "NA": "-", "No": "No"]
        default: dict = ["Yes": "", "NA": "", "No": ""]
        }
        
        return dict
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
