//
//  Constant.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 22/04/2021.
//

import Foundation
import UIKit

struct API {
    static let URL = "http://api.tiin.vn/TiinAPI/ws/"
    static let GET_NEWS = URL+"news/getArticleOfCategory"
    static let GET_NEWS_DETAIL = URL+"news/getArticleFastRead"
    static let GET_NEWS_RELATED = URL + "news/getArticleSiblings"
    static let GET_VIDEO = URL+"news/getListVideoHomepage"
    static let GET_VIDEO_DETAIL = URL + "news/getVideoDetail"
    static let GET_IMAGE = URL + "news/getHomepageArticleImage"
    static let GET_IMAGE_DETAIL = URL+"news/getPhotoListOfArticle"
    static let GET_SEARCH = URL + "others/searchDetail"
}
struct CATEGORY {
    static let CATEGORY_ITEM: [(String,Int)] = [
        ("GameZ", 120),
        ("Nhạc", 3),
        ("Sao", 2),
        ("Phim", 4),
        ("Đẹp",6),
        ("Sống", 9),
        ("Học", 10),
        ("Yêu", 11),
        ("Nghiệm", 93),
        ("Vui", 12),
        ("24H", 8),
        ("Sành", 5)
    ]
    
    static let MENU_ITEM : [(String, String)] = [
        ("m_tintuc", "Tin tức"),
        ("",""),
        ("m_video", "Video"),
        ("m_anh", "Ảnh"),
        ("m_noti", "Nhận tin nổi bật"),
        ("m_vip", "Gói VIP Tiin"),
        ("m_thongtin", "Thông tin"),
        ("m_lienhe", "Liên hệ"),
        ("m_application", "Ứng dụng khác"),
        ("m_voted", "Bình chọn Tiin")
    ]
}

struct PAGE {
    static let limit = 10
}

struct STYLE {
    static let THEME_COLOR = UIColor(red: 221/255, green: 34/255, blue: 107/255, alpha: 1)
}

extension String {
 var htmlToAttributedString: NSMutableAttributedString? {
    guard let data = data(using: .utf8) else { return nil }
    do {
        return try NSMutableAttributedString(data: data,
                                      options: [.documentType: NSMutableAttributedString.DocumentType.html,
                                                .characterEncoding: String.Encoding.utf8.rawValue],
                                      documentAttributes: nil)
    } catch let error as NSError {
        print(error.localizedDescription)
        return  nil
    }
 }
}

extension UITextView {

    func numberOfCharactersThatFitTextView() -> Int {
        let fontRef = CTFontCreateWithName(font!.fontName as CFString, font!.pointSize, nil)
        let attributes = [kCTFontAttributeName : fontRef]
        let attributedString = NSAttributedString(string: text!, attributes: attributes as [NSAttributedString.Key : Any])
        let frameSetterRef = CTFramesetterCreateWithAttributedString(attributedString as CFAttributedString)

        var characterFitRange: CFRange = CFRange()

        CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, CFRangeMake(0, 0), nil, CGSize(width: bounds.size.width, height: bounds.size.height), &characterFitRange)
        return Int(characterFitRange.length)

    }
}

extension UILabel {

    func numberOfCharactersThatFitLabe() -> Int {
        let fontRef = CTFontCreateWithName(font!.fontName as CFString, font!.pointSize, nil)
        let attributes = [kCTFontAttributeName : fontRef]
        let attributedString = NSAttributedString(string: text!, attributes: attributes as [NSAttributedString.Key : Any])
        let frameSetterRef = CTFramesetterCreateWithAttributedString(attributedString as CFAttributedString)

        var characterFitRange: CFRange = CFRange()

        CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, CFRangeMake(0, 0), nil, CGSize(width: bounds.size.width, height: bounds.size.height), &characterFitRange)
        return Int(characterFitRange.length)

    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
