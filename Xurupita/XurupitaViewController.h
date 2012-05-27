//  Created by Sir Cheshire

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"
@class LogicCore;

@interface XurupitaViewController : UIViewController<ADBannerViewDelegate>
{
    NSMutableArray* butons;
    NSMutableArray* delButons;
    
    NSArray* tipos;
    NSArray* tiposEng;

    CGSize gap;
    CGPoint current;

    CGRect buttonFrame;
    CGRect textFrame;
    CGRect deleteFrame;
    
    BOOL trash;
    
    LogicCore *core;
    UIScrollView *scrollView;
    ADBannerView *adBanner;
    
    BOOL bannerIsVisible;
       
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,assign) BOOL bannerIsVisible;
@property (strong, nonatomic) IBOutlet UIButton *aboutButton;
@property (strong, nonatomic) IBOutlet UIButton *defineButton;
@property (strong, nonatomic) IBOutlet UIView *bgScroll;
@property (strong, nonatomic) IBOutlet UIButton *trashDois;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;




- (IBAction)toggleDelete:(id)sender;
- (IBAction)changePass:(id)sender;
- (IBAction)sendMail:(id)sender;
- (IBAction)goAppStore:(id)sender;
- (IBAction)adicionarDoc:(id)sender;
- (IBAction)goAbout:(id)sender;


@end
