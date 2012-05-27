//  Created by Sir Cheshire
#import <UIKit/UIKit.h>

@interface ZoomableImage : UIViewController<UIScrollViewDelegate>
{
    UIImage* img;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong) UIImage* img;

@end
