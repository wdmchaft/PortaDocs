//  Created by Sir Cheshire

#import <UIKit/UIKit.h>
@class LogicCore;

@interface TelaAdicao : UIViewController<UIActionSheetDelegate>
{
    NSMutableArray* butons;
    
    LogicCore* core;
    
    NSArray* tipos;
    
    NSArray* original;
    
    int buttonHeight;
    int buttonWidth;
    int buttonTop;
    int buttonLeft;
    
    int startPoint;
    int gap;
    UIScrollView *scrollView;
    
    UINavigationItem *navItem;
}
@property (strong, nonatomic) IBOutlet UIButton *botRet;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
- (IBAction)retornar:(id)sender;
-(id) initWithList:(NSArray*) docs;
-(void) setOriginal:(NSArray*) lista;

@end
