//
//  NewIssueTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/15/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewIssueTableViewController: UITableViewController, UITextViewDelegate {
    
    var currentRepoName: String?
    
    var issue: Issue?
    
    @IBOutlet weak var submitBarButton: UIBarButtonItem!
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextView.delegate = self
        titleTextView.becomeFirstResponder()
        commentTextView.delegate = self
        
        titleTextView.text = "Title..."
        titleTextView.textColor = UIColor.lightGrayColor()
        titleTextView.selectedTextRange = titleTextView.textRangeFromPosition(titleTextView.beginningOfDocument, toPosition: titleTextView.beginningOfDocument)
        titleTextView.keyboardType = UIKeyboardType.Twitter
        
        commentTextView.text = "Leave a comment..."
        commentTextView.textColor = UIColor.lightGrayColor()
        commentTextView.selectedTextRange = titleTextView.textRangeFromPosition(titleTextView.beginningOfDocument, toPosition: titleTextView.beginningOfDocument)
        commentTextView.keyboardType = UIKeyboardType.Twitter
        
        submitBarButton.enabled = false
        
    }

//    func textViewDidChange(textView: UITextView) {
//        
//        let fixedWidth = textView.frame.size.width
//        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//        var newFrame = textView.frame
//        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//        textView.frame = newFrame;
//        textView.scrollEnabled = true
//        
//    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textview text and the replacement text to
        // create the updated text string
        let currentText : NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, disable the submitBarButton,
        // add the placeholder, and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            if textView == self.titleTextView {
                textView.text = "Title..."
                submitBarButton.enabled = false
            } else if textView == self.commentTextView {
                textView.text = "Leave a comment..."
            }
            
            textView.textColor = UIColor.lightGrayColor()
            
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
            // Note: Issue must have a title to be submitted
        else if (textView.textColor == UIColor.lightGrayColor() && !(text.isEmpty)) {
            
            if textView == self.titleTextView {
                submitBarButton.enabled = true
            }
            
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
        
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        
        if textView.textColor == UIColor.lightGrayColor() {
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
        }
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func submitTapped(sender: AnyObject) {
        
        print("submitTapped().")
        
        print("currentRepoName!: \(currentRepoName!)")
        
        self.submitBarButton.enabled = false
        
        let headers = [
            "Authorization": Constants.token,
            "Accept": "application/vnd.github.v3+json"
        ]
        
        let parameters = [
            "title": self.titleTextView.text,
            "body":  self.commentTextView.text
        ]
        
        Alamofire.request(.POST, "https://api.github.com/repos/dnadri/\(currentRepoName!)/issues", parameters: parameters, encoding: .JSON, headers: headers).validate(statusCode: 200..<300).responseJSON { response in
                
                guard response.result.error ==  nil else {
                    // ERROR
                    print("ERROR: \(response.result.error!)")
                    
                    return
                }
                
                if let value = response.result.value {
                    // SUCCESS
                    let issue = JSON(value)
                    print("SUCCESS: New Issue: \(issue.description)")
                }
                
        }
     
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
