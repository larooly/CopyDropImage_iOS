//
//  ViewController.m
//  TestClipboard
//
//  Created by active on 2021/05/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __inputText.pasteDelegate = self;
  
}
-(void)textPasteConfigurationSupporting:(id<UITextPasteConfigurationSupporting>)textPasteConfigurationSupporting transformPasteItem:(id<UITextPasteItem>)item API_AVAILABLE(ios(11.0)) {
       [self paste:textPasteConfigurationSupporting];
   }
- (void)paste:(id)sender
{
    NSLog(@"Really paste>?");
    UIImage *img = [UIPasteboard generalPasteboard].image;
    NSString *test = [UIPasteboard generalPasteboard].string;
    if(img){
        [self show2:img sizeofImage:100];
        NSLog(@"Really img>?");
        __imageView.image = img;
        
    }
    else if(test){
        NSLog(@"Really text>?");
        [__inputText replaceRange:__inputText.selectedTextRange withText:test];
//        __inputText.text = test;
    }
    else if( [UIPasteboard generalPasteboard].pasteboardTypes){
        UIAlertController *alert = [ UIAlertController alertControllerWithTitle:@"오류" message:@"지원하지 않는 파일 형식입니다." preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *actionCancel = [ UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:actionCancel];
        [ self presentViewController:alert animated:YES completion:nil ];
        
//        NSLog(@"file? %@",[UIPasteboard generalPasteboard].pasteboardTypes);
//        NSArray *array = [UIPasteboard generalPasteboard].items;
//        NSURL *data = [array objectAtIndex:0];
//        NSLog(@"이데... %@  //  %@",data,[array objectAtIndex:0]);
        
    };
}
-(void)show:(UIImage *)image{
    UIAlertController *alert = [ UIAlertController alertControllerWithTitle:@"이미지 저장" message:@"이미지가 성공적으로 저장되었습니다." preferredStyle:UIAlertControllerStyleAlert ];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    imageView.image = image;
//    [alert.view addSubview:imageView];
    
    UIAlertAction *actionImage = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil];
    
    
    
    CGRect rect = CGRectMake(0,0,100,100);
        UIGraphicsBeginImageContext( rect.size );
        [image drawInRect:rect];
        UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
//    [actionImage setValue:image forKey:@"image"];
    [actionImage setValue:[image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    [alert addAction:actionImage];
    
    UIAlertAction *actionOK = [ UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^( UIAlertAction *action )
                               {
                               } ];
    
    [ alert addAction:actionOK ];
    
    [ self presentViewController:alert animated:YES completion:nil ];
    
}
-(void)show2:(UIImage *)image sizeofImage:(int)size{
    UIAlertController *alert = [ UIAlertController alertControllerWithTitle:@"이미지 전송" message:@"해당 이미지를 전송하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert ];
    UIViewController *viewController = [[UIViewController alloc]init];
    UIImageView * imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size, size)];//viewController.view.frame
    imView.contentMode = UIViewContentModeScaleAspectFit;
    imView.image = image;
    [viewController.view addSubview:imView];
    viewController.preferredContentSize = CGSizeMake(size, size+10);
    [alert setValue: viewController forKey:@"contentViewController"];
    //여기까지 이미지 추가
    UIAlertAction *actionOK = [ UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^( UIAlertAction *action ){   } ];
    UIAlertAction *actionCancel = [ UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionOK];
    [alert addAction:actionCancel];
    [ self presentViewController:alert animated:YES completion:nil ];
}

@end
