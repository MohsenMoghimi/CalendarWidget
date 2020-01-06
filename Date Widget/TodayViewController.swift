//
//  TodayViewController.swift
//  Date Widget
//
//  Created by Mohsen Moghimi on 1/5/20.
//  Copyright © 2020 Mohsen Moghimi. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var shamsiDate: UILabel!
    @IBOutlet weak var kharejiDate: UILabel!
    @IBOutlet weak var ghamariDate: UILabel!
    
    fileprivate var now = Date()
    
    fileprivate let shamsiFormatter = DateFormatter()
    fileprivate let kharejiFormatter = DateFormatter()
    fileprivate let ghamariFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureOnShamsi = UITapGestureRecognizer(target: self, action: #selector(shamsiTapped(tapGestureRecognizer:)))
        shamsiDate.isUserInteractionEnabled = true
        shamsiDate.addGestureRecognizer(tapGestureOnShamsi)
        
        let tapGestureOnKhareji = UITapGestureRecognizer(target: self, action: #selector(kharejiTapped(tapGestureRecognizer:)))
        kharejiDate.isUserInteractionEnabled = true
        kharejiDate.addGestureRecognizer(tapGestureOnKhareji)
        
        let tapGestureOnGhamari = UITapGestureRecognizer(target: self, action: #selector(ghamariTapped(tapGestureRecognizer:)))
        ghamariDate.isUserInteractionEnabled = true
        ghamariDate.addGestureRecognizer(tapGestureOnGhamari)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        now = Date()
        configDates()
    }
    
    fileprivate func configShamsiDate() {
        shamsiFormatter.timeStyle = .none
        shamsiFormatter.dateStyle = FormatterStyleManager.shared.getShamsiStyle()
        shamsiFormatter.calendar = Calendar(identifier: .persian)
        shamsiDate.text = shamsiFormatter.string(from: now)
    }
    
    fileprivate func configKharejiDate() {
        kharejiFormatter.timeStyle = .none
        kharejiFormatter.dateStyle = FormatterStyleManager.shared.getKharejiStyle()
        kharejiDate.text = kharejiFormatter.string(from: now)
    }
    
    fileprivate func configGhamariDate() {
        ghamariFormatter.timeStyle = .none
        ghamariFormatter.dateStyle = FormatterStyleManager.shared.getGhamariStyle()
        ghamariFormatter.calendar = Calendar(identifier: .islamicCivil)
        ghamariDate.text = ghamariFormatter.string(from: now)
    }
    
    fileprivate func configDates() {
        configShamsiDate()
        configKharejiDate()
        configGhamariDate()
    }
    
    fileprivate func changeShamsiFormatterStyle() {
        if shamsiFormatter.dateStyle == .full {
            FormatterStyleManager.shared.setShamsiStyleTo(style: .long)
        } else if shamsiFormatter.dateStyle == .long {
            FormatterStyleManager.shared.setShamsiStyleTo(style: .medium)
        } else if shamsiFormatter.dateStyle == .medium {
            FormatterStyleManager.shared.setShamsiStyleTo(style: .short)
        } else if shamsiFormatter.dateStyle == .short {
            FormatterStyleManager.shared.setShamsiStyleTo(style: .full)
        }
        configShamsiDate()
    }
    
    fileprivate func changeKharejiFormatterStyle() {
        if kharejiFormatter.dateStyle == .full {
            FormatterStyleManager.shared.setKharejiStyleTo(style: .long)
        } else if kharejiFormatter.dateStyle == .long {
            FormatterStyleManager.shared.setKharejiStyleTo(style: .medium)
        } else if kharejiFormatter.dateStyle == .medium {
            FormatterStyleManager.shared.setKharejiStyleTo(style: .short)
        } else if kharejiFormatter.dateStyle == .short {
            FormatterStyleManager.shared.setKharejiStyleTo(style: .full)
        }
        configKharejiDate()
    }
    
    fileprivate func changeGhamariFormatterStyle() {
        if ghamariFormatter.dateStyle == .full {
            FormatterStyleManager.shared.setGhamariStyleTo(style: .long)
        } else if ghamariFormatter.dateStyle == .long {
            FormatterStyleManager.shared.setGhamariStyleTo(style: .medium)
        } else if ghamariFormatter.dateStyle == .medium {
            FormatterStyleManager.shared.setGhamariStyleTo(style: .short)
        } else if ghamariFormatter.dateStyle == .short {
            FormatterStyleManager.shared.setGhamariStyleTo(style: .full)
        }
        configGhamariDate()
    }
    
    @objc func shamsiTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        changeShamsiFormatterStyle()
    }
    
    @objc func kharejiTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        changeKharejiFormatterStyle()
    }
    
    @objc func ghamariTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        changeGhamariFormatterStyle()
    }
    
    private func toggleLineChart() {
        let expanded = extensionContext!.widgetActiveDisplayMode == .expanded
        if expanded {
            kharejiDate.isHidden = true
            ghamariDate.isHidden = true
        } else {
            kharejiDate.isHidden = false
            ghamariDate.isHidden = false
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 200) : maxSize
        toggleLineChart()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
}
