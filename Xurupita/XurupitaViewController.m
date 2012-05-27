//  Created by Sir Cheshire

#import "XurupitaViewController.h"
#import "LogicCore.h"
#import "TelaAdicao.h"
#import "Login.h"
#import "CreatePass.h"
#import "About.h"
#import "SelectMail.h"
#import "TelaImages.h"

@implementation XurupitaViewController
@synthesize aboutButton;
@synthesize defineButton;
@synthesize bgScroll;
@synthesize trashDois;
@synthesize navItem;
@synthesize scrollView;
@synthesize bannerIsVisible;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(NSString*) searchIcon:(NSString*) nome
{
#ifdef PT
    if ([tipos containsObject:nome]) 
    {
        nome = [NSString stringWithFormat:@"%@.png",nome];
        return[nome stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    }
    else
    {
        return @"Outro.png";
    }
#endif
    
#ifdef ENG
    
    if ([tiposEng containsObject:nome] && !([nome isEqualToString:@"VIP Card"] || [nome isEqualToString:@"Reward Card"])) 
    {
        nome = [NSString stringWithFormat:@"%@.png",[tipos objectAtIndex:[tiposEng indexOfObject:nome]]];
        return[nome stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    }
    else if ([nome isEqualToString:@"VIP Card"] || [nome isEqualToString:@"Reward Card"]) 
    {
        
        nome = [NSString stringWithFormat:@"%@.png",nome];
        return[nome stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    }
    else
    {
        return @"Outro.png";
    }
        
#endif    
    
}
-(void) setInterface
{
    [[scrollView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    NSArray* temp = [core getDocs];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        gap = CGSizeMake(192, 220);
        
        current = CGPointMake(0, 0);
        
        buttonFrame = CGRectMake(32, 32, 128, 128);
        
        textFrame = CGRectMake(12, 155, 167, 84);
        
        deleteFrame = CGRectMake(18, 18, 48, 48);
        
        [scrollView setContentSize:CGSizeMake(768,0)];
    }
    else
    {
        gap = CGSizeMake(106, 110);
        
        current = CGPointMake(0, 0);
        
        buttonFrame = CGRectMake(21, 21, 64, 64);
        
        textFrame = CGRectMake(8, 80, 90, 37);
        
        deleteFrame = CGRectMake(15, 15, 24, 24);
        
        [scrollView setContentSize:CGSizeMake(320,0)];
    }
    
    [scrollView setScrollEnabled:YES];
    
    butons = [NSMutableArray new];
    delButons = [NSMutableArray new];
    
    for (NSString * s in temp) 
    {
        UIButton* buttonCat = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIButton* buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [buttonCat addTarget:self action:@selector(pop:)forControlEvents:UIControlEventTouchUpInside];
        
        [buttonDelete addTarget:self action:@selector(deleteDoc:)forControlEvents:UIControlEventTouchUpInside];
        
        [buttonCat setTitle:@"" forState:UIControlStateNormal];
        
        [buttonDelete setTitle:@"" forState:UIControlStateNormal];
        
        [buttonDelete setHidden:trash];
        
        
        [buttonCat setBackgroundImage:[UIImage imageNamed:[self searchIcon:s]] forState:UIControlStateNormal];
        
        [buttonDelete setBackgroundImage:[UIImage imageNamed:@"Remover.png"] forState:UIControlStateNormal];
        
        UIView* holdView = [[UIView alloc] initWithFrame:CGRectMake(current.x, current.y, gap.width, gap.height)];
        
        buttonCat.frame = buttonFrame;
        
        buttonDelete.frame = deleteFrame;
        
        UILabel* texto = [[UILabel alloc] initWithFrame:textFrame];
        [texto setMinimumFontSize:0];
        texto.numberOfLines = 2;
        texto.textAlignment = UITextAlignmentCenter;
        [texto setBackgroundColor:[UIColor clearColor]];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            texto.font = [UIFont fontWithName:@"Helvetica" size:24];
        }
        else
        {
            texto.font = [UIFont fontWithName:@"Helvetica" size:12];
        }
        
        texto.text=s;
        
        [butons addObject:buttonCat];
        [delButons addObject:buttonDelete];

        [holdView addSubview:[butons lastObject]];
        [holdView addSubview:[delButons lastObject]];
        [holdView addSubview:texto];
        
        [scrollView addSubview:holdView];
        
        int loops;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            loops = 3;
        }
        else
        {
            loops = 2;
        }
        
        if (current.x != loops*gap.width) 
        {
            current.x = current.x+gap.width;
            
            if (current.x == gap.width) 
            {
                [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height+gap.height)];
            }
        }
        else
        {
            current.y = current.y+gap.height;
            
            current.x = 0;
        }
    }
}

-(void) deleteDoc:(id) sender
{
    [core deleteDoc:[[core getDocs]objectAtIndex:[delButons indexOfObject:sender]]];
    
    [self setInterface];
}

-(void) changeEnglish
{
	[navItem setTitle:@"Documents"];
    
    [aboutButton setTitle:@"About" forState:UIControlStateNormal];
    
    [defineButton setTitle:@"Define Password" forState:UIControlStateNormal];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [bgScroll setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundPattern.png"]]];
      
#ifdef ENG
    [self changeEnglish];
#endif
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [label setTextAlignment:UITextAlignmentCenter];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1.0]];
    
	[label setText:navItem.title];
	[navItem setTitleView:label];

    core = [[LogicCore alloc] init];
    
    trash = YES;

    tiposEng = [[NSArray alloc] initWithObjects:@"ID",@"ZERO",@"Driver's License",@"School ID",@"Birth Certificate",@"U.S Military Card",@"Passport",@"Reward Card",@"VIP Card",@"Business Card",@"Insurance Card",@"Residency Certification",@"Voter Registration",@"Visa",@"MasterCard",@"Diners Club",@"American Express",@"Aura",@"Hipercard",@"Health Insurance",@"Business Contract",@"Business License",@"ZERO", nil];
   
    tipos = [[NSArray alloc] initWithObjects:@"Identidade", @"CPF", @"Carteira de Motorista",@"Carteira de Estudante",@"Certidão de Nascimento",@"Certificado de Reservista",@"Passaporte",@"TAM Fidelidade",@"GOL Smiles",@"Cartão de Visita",@"Cartão da Seguradora",@"Comprovante de Residência",@"Titulo de Eleitor",@"Visa",@"MasterCard",@"Diners Club",@"American Express",@"Aura",@"Hipercard",@"Plano de Saúde",@"Contrato Social",@"Alvará de Localização",@"CNPJ", nil];

    
#ifdef LITE
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CGRect temp = scrollView.frame;
        temp.size.height=325;
        [scrollView setFrame:temp];
    }
    else
    {
        CGRect temp = scrollView.frame;
        temp.size.height=803;
        [scrollView setFrame:temp];
    } 
    
    trashDois.enabled = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 878, 320, 50)];
        adBanner.frame = CGRectOffset(adBanner.frame, 0, -980);
    }
    else
    {
        adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 352, 320, 50)];
        adBanner.frame = CGRectOffset(adBanner.frame, 0, -420);
    }
    
    adBanner.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    adBanner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:adBanner];
    adBanner.delegate=self;
    self.bannerIsVisible=NO;
#endif
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            banner.frame = CGRectOffset(banner.frame, 0, 980);
        }
        else
        {
            banner.frame = CGRectOffset(banner.frame, 0, 420);
        }
        
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            banner.frame = CGRectOffset(banner.frame, 0, -980);
        }
        else
        {
            banner.frame = CGRectOffset(banner.frame, 0, -420);
        }
        
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
    NSLog(@"erro");
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setAboutButton:nil];
    [self setBgScroll:nil];
    [self setTitle:nil];
    [self setTrashDois:nil];
    [self setAboutButton:nil];
    [self setDefineButton:nil];
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

- (void)pop:(id)sender 
{
    if (!trash) 
    {
        [self toggleDelete:nil];
    }
    
    NSString* titulo = [[core getDocs] objectAtIndex:[butons indexOfObject:sender]];
  
    TelaImages* screen = [[TelaImages alloc] init];
    
    screen.titulo = titulo;
    
    [screen setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentModalViewController:screen animated:YES];
}

- (IBAction)toggleDelete:(id)sender 
{
    trash = !trash;
    if (trash) 
    {
        [trashDois setBackgroundImage:[UIImage imageNamed:@"LixeiraCheia.png"] forState:UIControlStateNormal];
    }
    else
    {
        
        [trashDois setBackgroundImage:[UIImage imageNamed:@"LixeiraVazia.png"] forState:UIControlStateNormal];
    }
    for (int i = 0; i < [delButons count]; i++) 
    {
        [[delButons objectAtIndex:i] setHidden:trash];
    }
}

- (IBAction)adicionarDoc:(id)sender
{
    if (!trash) 
    {
        [self toggleDelete:nil];
    }
    
#ifdef PT
    TelaAdicao* temp = [[TelaAdicao alloc] initWithList:tipos];
#endif
    
#ifdef ENG
    TelaAdicao* temp = [[TelaAdicao alloc] initWithList:tiposEng];
    [temp setOriginal : tipos];
#endif
 
    
    temp.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:temp animated:YES];
    
}

- (IBAction)goAbout:(id)sender 
{
    if (!trash) 
    {
        [self toggleDelete:nil];
    }
    
    About* about = [[About alloc] init];
    
    [about setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentModalViewController:about animated:YES];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self setInterface];
}

- (IBAction)changePass:(id)sender 
{
    if (!trash) 
    {
        [self toggleDelete:nil];
    }
    
    CreatePass* create = [[CreatePass alloc] init];
    
    [create setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentModalViewController:create animated:YES];
}

- (IBAction)sendMail:(id)sender 
{
    if (!trash) 
    {
        [self toggleDelete:nil];
    }
    
#ifdef ENG
    SelectMail* mailScreen = [[SelectMail alloc] initWithDocs:[core getDocs] tipos:tiposEng];
    [mailScreen setOriginal:tipos];
#endif
    
#ifdef PT
    SelectMail* mailScreen = [[SelectMail alloc] initWithDocs:[core getDocs] tipos:tipos];
#endif
    
    [mailScreen setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentModalViewController:mailScreen animated:YES];
    
}

- (IBAction)goAppStore:(id)sender 
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/costa-dos-coqueiros-hd/id467166875?l=pt&ls=1&mt=8"]];    
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/br/app/costa-dos-coqueiros/id462910988?mt=8"]];
    }
    
}
@end
