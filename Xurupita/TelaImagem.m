//  Created by Sir Cheshire

#import "TelaImagem.h"
#import "LogicCore.h"
#import "Login.h"

@implementation TelaImagem
@synthesize defButton;
@synthesize botRet;
@synthesize imageView;
@synthesize scrollView;
@synthesize naviTitulo;
@synthesize popper;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithNome:(NSString*) name  isFront:(BOOL) isF
{
    self = [super init];
    if(self)
    {
        titulo = name;
        isFront = isF;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//começa oque foi colado
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

-(void) setInterface
{
    scrollView.bouncesZoom = YES;  
    scrollView.delegate = self;  
    scrollView.clipsToBounds = YES;
    
    imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );  

    scrollView.contentSize = [imageView frame].size;
    
    float minimumScale = [scrollView frame].size.width  / [imageView frame].size.width;  
    
    scrollView.minimumZoomScale = minimumScale;  
    scrollView.zoomScale = minimumScale;  
}

//termina oque foi colado

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    naviTitulo.title = titulo;
    
    NSMutableString* nome = [NSMutableString stringWithString:titulo];
    
    if (isFront) 
    {
        [nome appendString: @"F"];
    }
    else
    {
        [nome appendString:@"V"];
    }
    
    
    //imageView.image = [LogicCore loadImage:nome];
    
#ifdef ENG
    [botRet setTitle:@"Return"];
    [defButton setTitle:@"Set Image"];
#endif
    
    [self setInterface];
        // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [self setNaviTitulo:nil];
    [self setBotRet:nil];
    [self setDefButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)retornar:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) takePhoto
{
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [picker setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
        [self presentModalViewController: picker animated:YES];
    }  
    else
    {
#ifdef ENG
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"Error." message: @"No camera available." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alert show];
        
#endif
#ifdef PT
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"Erro." message: @"Dispositivo não possui camera." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
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
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
             
            self.popper = [[UIPopoverController alloc] initWithContentViewController:picker];
            
            [popper presentPopoverFromBarButtonItem:defButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else
        {
            [picker setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentModalViewController:picker animated:YES];

        }
        
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage : (UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSMutableString* nome = [NSMutableString stringWithString:titulo];
    
    if (isFront) 
    {
        [nome appendString: @"F"];
    }
    else
    {
        [nome appendString:@"V"];
    }
    
   // [LogicCore saveImage:image name:[nome copy]];
    
    //imageView.image = [LogicCore loadImage:[nome copy]];
    
   
    
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    [picker dismissModalViewControllerAnimated:YES];
}
- (IBAction)setImagem:(id)sender 
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
@end
