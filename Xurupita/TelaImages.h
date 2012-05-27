//  Created by Sir Cheshire

#import <UIKit/UIKit.h>

@interface TelaImages : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{
    NSString* titulo;
    
    NSMutableArray* views;
    
    int jump;
    
    UIPopoverController* popper;
    
    UIActionSheet* confirmation;
    UIActionSheet* buy;
}

- (IBAction)ret:(id)sender;
- (void)add;
- (IBAction)editImage:(id)sender;
-(void) deleteDoc;

@property (strong, nonatomic) IBOutlet UIButton *retButton;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property(strong) NSString* titulo;
@property (strong, nonatomic) IBOutlet UINavigationBar *barra;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property(strong) UIPopoverController *popper;
@property (strong, nonatomic) IBOutlet UIPageControl *pager;


@end
