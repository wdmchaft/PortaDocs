//  Created by Sir Cheshire

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SelectMail : UIViewController <MFMailComposeViewControllerDelegate>
{
    NSArray* docsToSelect;
    NSArray* tipos;
    
    NSArray* original;
    
    int imageHeight;
    int imageWidth;
    int imageTop;
    int imageLeft;
    
    int labelHeight;
    int labelWidth;
    int labelTop;
    int labelLeft;
    
    int buttonHeight;
    int buttonWidth;
    int buttonTop;
    int buttonLeft;
    
    int startPoint;
    int gap;
    UIScrollView *scrollView;
    
    NSMutableArray* butons;
    
    UINavigationItem *navItem;
}
@property (strong, nonatomic) IBOutlet UIButton *botaoRet;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
-(id) initWithDocs:(NSArray*) docs tipos:(NSArray*) types;
-(IBAction)retornar:(id)sender;
-(void) setOriginal:(NSArray*) lista;

@end
