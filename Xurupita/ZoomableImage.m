//  Created by Sir Cheshire

#import "ZoomableImage.h"

@implementation ZoomableImage
@synthesize scrollView;
@synthesize imageView;
@synthesize img;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView 
{  
    return imageView;  
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {  
    
    CGRect zoomRect;  
    
    // the zoom rect is in the content view's coordinates.   
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.  
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.  
    zoomRect.size.height = [scrollView frame].size.height / scale;  
    zoomRect.size.width  = [scrollView frame].size.width  / scale;  
    
    // choose an origin so as to get the right center.  
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);  
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);  
    
    
    return zoomRect;  
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor* bg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundPattern.png"]];
    
    [scrollView setBackgroundColor:bg];
    
    scrollView.bouncesZoom = YES;  
    scrollView.delegate = self;  
    scrollView.clipsToBounds = YES;
    
    imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );  
    
    scrollView.contentSize = [imageView frame].size;
    
    float minimumScale = [scrollView frame].size.width  / [imageView frame].size.width;  
    
    scrollView.minimumZoomScale = minimumScale;  
    scrollView.zoomScale = minimumScale;
    
    [imageView setImage:img];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
