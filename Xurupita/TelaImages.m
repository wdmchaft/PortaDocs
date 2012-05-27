//  Created by Sir Cheshire

#import "TelaImages.h"
#import "LogicCore.h"
#import "ZoomableImage.h"

@implementation TelaImages

@synthesize pager;
@synthesize popper;
@synthesize retButton;
@synthesize navItem;
@synthesize titulo;
@synthesize barra;
@synthesize scroll;

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

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scroll.frame.size.width;
    int page = floor((scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    
    if (page != [pager currentPage]) 
    {
        ZoomableImage* temp = [views objectAtIndex:pager.currentPage];
        if (temp.scrollView.zoomScale != 1.0) 
        {
           [temp.scrollView setZoomScale:1.0]; 
        }
        
        [pager setCurrentPage:page];
        
    }
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    [((UINavigationItem*)[barra.items objectAtIndex:0]) setTitle : titulo];
    
    views = [NSMutableArray new];
    
    [scroll setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundPattern.png"]]];
    
    [scroll setDelegate:self];
    
#ifdef ENG
    [retButton setTitle:@"Return" forState:UIControlStateNormal];
#endif
    UILabel *label;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(-100, 0, 320, 30)];
    }
    else
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(-125, 0, 240, 30)];
    }
    
    [label setTextAlignment:UITextAlignmentCenter];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1.0]];
    
	[label setText:navItem.title];
	[navItem setTitleView:label];
    
    jump = scroll.frame.size.width;
    
    NSMutableArray* imgs = [LogicCore loadImagesfromDoc:titulo];
    
    pager.numberOfPages = [imgs count];
    
    for (UIImage * i in imgs) 
    {
        int index = [imgs indexOfObject:i];
        
        ZoomableImage* controller = [[ZoomableImage alloc] init];
        
        controller.img = i;
        
        CGRect temp = controller.view.frame;
        
        temp.origin.x = index*jump;
        
        [controller.view setFrame:temp];
        
        [views addObject:controller];
        
        [scroll setContentSize:CGSizeMake(scroll.contentSize.width+scroll.frame.size.width, scroll.frame.size.height)];
        
        [scroll addSubview:controller.view];
        
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBarra:nil];
    [self setRetButton:nil];
    [self setScroll:nil];
    [self setPager:nil];
    [self setNavItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)ret:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)add 
{
    BOOL ok = NO;
    if ([views count] != 2) 
    {
        ok = YES;
    }
    else
    {
#ifdef FULL
        ok = YES;
#endif
    }
    
    if (ok) 
    {
#ifdef ENG
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Select the source of the image" delegate:self cancelButtonTitle:@"Library" otherButtonTitles:@"Camera", nil];
        [alert show];
#endif
        
#ifdef PT
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Selecione a origem da imagem" delegate:self cancelButtonTitle:@"Biblioteca" otherButtonTitles:@"Camera", nil];
        [alert show];
#endif
    }
    else
    {
#ifdef PT
        buy = [[ UIActionSheet alloc] initWithTitle:@"A versão Lite só permite duas imagens por documento.\nDeseja comprar a versão completa?" delegate:self cancelButtonTitle:@"Não, obrigado" destructiveButtonTitle:@"Comprar ($ 0.99)" otherButtonTitles:nil];
        
        [buy showInView:self.view];
#endif
        
#ifdef ENG
        buy = [[ UIActionSheet alloc] initWithTitle:@"The Lite version allows only two images per document.\nDo you wish to buy the full version?" delegate:self cancelButtonTitle:@"No, thanks" destructiveButtonTitle:@"Buy ($ 0.99)" otherButtonTitles:nil];
        
        [buy showInView:self.view];
        
#endif 
    }
    

}

- (IBAction)editImage:(id)sender 
{
    UIActionSheet* sheet;
#ifdef ENG
        sheet = [[ UIActionSheet alloc] initWithTitle:@"Select the desired action" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Insert image",@"Remove image",nil];
        
#endif
    
#ifdef PT
    sheet = [[ UIActionSheet alloc] initWithTitle:@"Escolha a ação desejada" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Incluir imagem",@"Remover imagem",nil];
#endif
        [sheet showInView:self.view];
}

-(void) deleteDoc
{
    LogicCore* core = [[LogicCore alloc] init];
    [core removeImage:pager.currentPage fromDoc:titulo];
   
    [((ZoomableImage*)[views objectAtIndex:pager.currentPage]).view removeFromSuperview];
   
    [views removeObjectAtIndex:pager.currentPage];

    //linha problematica, da crash quando está no ultimo.
    
    for (int i = pager.currentPage; i < [views count]; i++) 
    {
        [UIView beginAnimations:@"movePanel" context:nil];
            
        CGRect frame =((ZoomableImage*)[views objectAtIndex:i]).view.frame;
           
        frame.origin.x = frame.origin.x - scroll.frame.size.width;
            
        ((ZoomableImage*)[views objectAtIndex:i]).view.frame = frame;
            
        [UIView commitAnimations];
    }
   
    [pager setNumberOfPages:pager.numberOfPages-1];
    [scroll setContentSize:CGSizeMake([views count]*scroll.frame.size.width, scroll.frame.size.height)];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == buy) 
    {
        if (buttonIndex == 0) 
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/safe-docs-hd/id474209487?l=pt&ls=1&mt=8"]]; 
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/safe-docs/id474209475?l=pt&ls=1&mt=8"]]; 
            }
        }
    } 
    else if (actionSheet == confirmation)
    {
        if (buttonIndex == 0) 
        {
            [self deleteDoc];
        }
    }
    else
    {
        if (buttonIndex == 0) 
        {
            [self add];
        }
        if ((buttonIndex == 1)&&(pager.numberOfPages > 0))   
        {
#ifdef ENG
            confirmation = [[ UIActionSheet alloc] initWithTitle:@"Are you sure you want to delete this image?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
#endif
            
#ifdef PT
            confirmation = [[ UIActionSheet alloc] initWithTitle:@"Tem certeza que deseja apagar esta imagem?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Sim" otherButtonTitles:@"Não",nil];
#endif
            [confirmation showInView:self.view];
        }
    }
}

-(void) takePhoto
{
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [picker setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
        [self presentModalViewController: picker animated:YES];
    }  
    else
    {
#ifdef ENG
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"Error." message: @"No camera available" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alert show];
        
#endif
#ifdef PT
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"Erro." message: @"Dispositivo não possui camera" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alert show];
        
#endif
        
    }
}

-(void) selectPhoto
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            self.popper = [[UIPopoverController alloc] initWithContentViewController:picker];
            
            [popper presentPopoverFromRect:CGRectMake(728, 7, 32, 29) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else
        {
            
            [picker setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentModalViewController:picker animated:YES];
            
        }
        
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        if (!popper.isPopoverVisible) 
        {
            [self selectPhoto];
        }
        
    }
    else
    {
        [self takePhoto];
    }
}

- (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
{  
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) 
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else 
        {
            scaleFactor = heightFactor; // scale to fit width
        }

        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) 
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else if (widthFactor < heightFactor) 
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }     
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) 
    {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } 
    else 
    {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }   
    
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    /*if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, radians(-180.));
    }*/
    
    CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage : (UIImage *)image editingInfo:(NSDictionary *)editingInfo
{     
    /**/
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform,image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (image.imageOrientation) 
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    image = img;
    /**/

    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) 
    {
        
        float imgRatio = image.size.width/image.size.height;
        float scrRatio = scroll.frame.size.width/scroll.frame.size.height;
        
        CGSize target;
        
        if (imgRatio > scrRatio) 
        {
            float height = scroll.frame.size.width/imgRatio;
            target = CGSizeMake(scroll.frame.size.width, height);
        }
        else
        {
            float width = scroll.frame.size.height*imgRatio;
            target = CGSizeMake(width, scroll.frame.size.height);
        }

        int factor = 2;
        
        target.width = target.width*factor;
        target.height = target.height*factor;
        
        
        image = [UIImage imageWithCGImage:[image CGImage] scale:2.0 orientation:UIImageOrientationUp];
        //image = [self imageWithImage:image scaledToSizeWithSameAspectRatio:target];
    }
    

    [LogicCore saveImage:image toDoc:titulo];


    ZoomableImage* controller = [[ZoomableImage alloc] init];

    controller.img = [[LogicCore loadImagesfromDoc:titulo] lastObject];
    
    CGRect temp = controller.view.frame;
    
    temp.origin.x = [views count]*jump;
    
    [controller.view setFrame:temp];

    [views addObject:controller];
    
    [scroll setContentSize:CGSizeMake(scroll.contentSize.width+scroll.frame.size.width, scroll.frame.size.height)];
    [scroll addSubview:controller.view];
    

    [picker dismissModalViewControllerAnimated:YES];
    
    [pager setNumberOfPages:pager.numberOfPages+1]; 
    
    if ([popper isPopoverVisible]) 
    {
        [popper dismissPopoverAnimated:YES];
    }

    [scroll scrollRectToVisible:temp animated:YES];
    
    [pager setCurrentPage:pager.numberOfPages];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    [picker dismissModalViewControllerAnimated:YES];
}
@end
