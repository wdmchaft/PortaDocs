//  Created by Sir Cheshire

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface About : UIViewController<MFMailComposeViewControllerDelegate> {
    UILabel *textoSmall;
    UILabel *labelTop;
    
    UITextView *aboutFull;
    UIBarButtonItem *retButton;
    UIImageView *fundoBarra;
    UINavigationItem *navItem;
}
@property (nonatomic, strong) IBOutlet UILabel *labelTop;
@property (strong, nonatomic) IBOutlet UIButton *botRet;

@property (nonatomic, strong) IBOutlet UITextView *aboutFull;
@property (nonatomic, strong) IBOutlet UIImageView *fundoBarra;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;

@property (nonatomic, strong) IBOutlet UILabel *textoSmall;
- (IBAction)return:(id)sender;
- (IBAction)clickLogo:(id)sender;
- (IBAction)clickFB:(id)sender;
- (IBAction)clickTwitter:(id)sender;
- (IBAction)clickMail:(id)sender;

@end
