//
//  ViewController.h
//  TestClipboard
//
//  Created by active on 2021/05/10.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextPasteDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *_imageView;
@property (weak, nonatomic) IBOutlet UITextView *_inputText;

@end

