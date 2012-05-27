//  Created by Sir Cheshire

#import "TelaAdicao.h"
#import "LogicCore.h"
#import "TelaOutro.h"

@implementation TelaAdicao
@synthesize botRet;
@synthesize navItem;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setOriginal:(NSArray*) lista
{
    original = lista;
}

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
    if ([tipos containsObject:nome] && !([nome isEqualToString:@"VIP Card"] || [nome isEqualToString:@"Reward Card"])) 
    {
        nome = [NSString stringWithFormat:@"%@.png",[original objectAtIndex:[tipos indexOfObject:nome]]];
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

-(id) initWithList:(NSArray*) docs
{
    self = [super init];
    
    if(self)
    {
        tipos = docs;   
        core = [[LogicCore alloc] init];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) addOutro
{
    TelaOutro* outro = [[TelaOutro alloc] init];
    
    [outro setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentModalViewController:outro animated:YES];
    
}

-(void) addDoc:(id) sender
{
#ifdef FULL
    if (sender == [butons lastObject]) 
    {
        [self addOutro];
    }
    else
    {
#ifdef PT
        if ([core insertDoc:[tipos objectAtIndex:[butons indexOfObject:sender]]]) 
        {
            //MANEIRA CERTA DA ERRADO
            [self dismissModalViewControllerAnimated:YES];
        }
        else
        {
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Erro" message: @"Item já existe" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];
            
        }
#endif
        
#ifdef ENG
        
        int ponto = [butons indexOfObject:sender]; 
        
        if (ponto > 0) 
        {
            ponto++;
        }
        
        if ([core insertDoc:[tipos objectAtIndex:ponto]]) 
        {
            [self dismissModalViewControllerAnimated:YES];
        }
        else
        {
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Error" message: @"Existing item" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];
            
        }
#endif
    }
#endif
    
#ifdef LITE
    
#ifdef PT
    UIActionSheet* sheet = [[ UIActionSheet alloc] initWithTitle:@"Esta ação necessita da versão completa.\nDeseja compra-la?" delegate:self cancelButtonTitle:@"Não, obrigado" destructiveButtonTitle:@"Comprar ($ 0.99)" otherButtonTitles:nil];
    
    [sheet showInView:self.view];
#endif
    
#ifdef ENG
    UIActionSheet* sheet = [[ UIActionSheet alloc] initWithTitle:@"This action requires the full version.\nDo you wish to buy it?" delegate:self cancelButtonTitle:@"No, thanks" destructiveButtonTitle:@"Buy ($ 0.99)" otherButtonTitles:nil];
    
    [sheet showInView:self.view];
    
#endif
    
#endif
   
    
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex) 
    {
#ifdef ENG
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/safe-docs-hd/id474209487?l=pt&ls=1&mt=8"]]; 
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/safe-docs/id474209475?l=pt&ls=1&mt=8"]]; 
        }
#endif
        
#ifdef PT
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/porta-docs-hd/id474206057?l=pt&ls=1&mt=8"]]; 
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/porta-docs/id473020557?l=pt&ls=1&mt=8"]]; 
        }
#endif
    }
}

#pragma mark - View lifecycle

-(void) setInterface
{
    startPoint = 0;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        gap = 160;
        
        buttonHeight = 160;
        buttonWidth =768;
        buttonTop = 0;
        buttonLeft = 0;
    }
    else
    {
        gap = 80;
        
        buttonHeight = 80;
        buttonWidth =320;
        buttonTop = 0;
        buttonLeft = 0;
    }
    
    [scrollView setContentSize:CGSizeMake(320,0)];
    
    [scrollView setScrollEnabled:YES];
    
    butons = [NSMutableArray new];
    
    for (NSString * s in tipos) 
    {
        if (![s isEqualToString:@"ZERO"]) 
        {
            UIButton* buttonCat = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [buttonCat setTitleColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1] forState:UIControlStateNormal];
            
            [buttonCat addTarget:self action:@selector(addDoc:)forControlEvents:UIControlEventTouchUpInside];
            
            [buttonCat setTitle:[NSString stringWithFormat: @"%@",s] forState:UIControlStateNormal];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [buttonCat.titleLabel setFont:[UIFont systemFontOfSize:28]];
                [buttonCat setBackgroundImage:[UIImage imageNamed:@"FundoAddIpad.png"] forState:UIControlStateNormal];
                [buttonCat setBackgroundImage:[UIImage imageNamed:@"FundoAddIpadOver.png"] forState:UIControlStateHighlighted];
            }
            else
            {
                [buttonCat setBackgroundImage:[UIImage imageNamed:@"FundoAdd.png"] forState:UIControlStateNormal];
                [buttonCat setBackgroundImage:[UIImage imageNamed:@"FundoAddOver.png"] forState:UIControlStateHighlighted];
            }
            
            buttonCat.frame = CGRectMake(buttonLeft, startPoint+buttonTop, buttonWidth, buttonHeight);
            
            [buttonCat setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            
            

            //mexi aqui //FODA-SE lolololol //alocs
            UIImageView* i= [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self searchIcon : s]]];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [i setFrame:CGRectMake(buttonLeft+20,startPoint+buttonTop+20,buttonWidth-648,buttonHeight-40)];
                [scrollView setContentSize:CGSizeMake(768,scrollView.contentSize.height+gap)];
                [buttonCat setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 150.0, 0.0, 0.0)];
            }
            else
            {
                [i setFrame:CGRectMake(buttonLeft+10,startPoint+buttonTop+10,buttonWidth-260,buttonHeight-20)];
                [scrollView setContentSize:CGSizeMake(320,scrollView.contentSize.height+gap)];
               [buttonCat setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 80.0, 0.0, 0.0)];
            }
            
            
            
            [butons addObject:buttonCat];
            
            [scrollView addSubview:[butons lastObject]];
            [scrollView addSubview:i];
        
            startPoint = startPoint+gap;
        }
    }
    
    UIButton* buttonCat = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [buttonCat setTitleColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    [buttonCat addTarget:self action:@selector(addDoc:)forControlEvents:UIControlEventTouchUpInside];
    
#ifdef PT
    [buttonCat setTitle:@"Outro" forState:UIControlStateNormal];
#endif
    
#ifdef ENG
    [buttonCat setTitle:@"Other" forState:UIControlStateNormal];
#endif
    
    [buttonCat setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    buttonCat.frame = CGRectMake(buttonLeft, startPoint+buttonTop, buttonWidth, buttonHeight);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [buttonCat setBackgroundImage:[UIImage imageNamed:@"FundoAddIpad.png"] forState:UIControlStateNormal];
        [buttonCat setBackgroundImage:[UIImage imageNamed:@"FundoAddIpadOver.png"] forState:UIControlStateHighlighted];
        [buttonCat setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 150.0, 0.0, 0.0)];
    }
    else
    {
        [buttonCat setBackgroundImage:[UIImage imageNamed:@"FundoAdd.png"] forState:UIControlStateNormal];
        [buttonCat setBackgroundImage:[UIImage imageNamed:@"FundoAddOver.png"] forState:UIControlStateHighlighted];
        [buttonCat setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 80.0, 0.0, 0.0)];
    }
    
    [butons addObject:buttonCat];
    
    [scrollView addSubview:[butons lastObject]];
    
    UIImageView *i= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Outro.png"]];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [i setFrame:CGRectMake(buttonLeft+20,startPoint+buttonTop+20,buttonWidth-648,buttonHeight-40)]; 
        [scrollView addSubview:i];
        [scrollView setContentSize:CGSizeMake(768,scrollView.contentSize.height+gap)];
        [buttonCat.titleLabel setFont:[UIFont systemFontOfSize:28]];
    }
    else
    {
        [i setFrame:CGRectMake(buttonLeft+10,startPoint+buttonTop+10,buttonWidth-260,buttonHeight-20)]; 
        [scrollView addSubview:i];
        [scrollView setContentSize:CGSizeMake(320,scrollView.contentSize.height+gap)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
#ifdef ENG
    [navItem setTitle:@"Select the Kind"];
    [botRet setTitle:@"Return" forState:UIControlStateNormal];
#endif
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [label setTextAlignment:UITextAlignmentCenter];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1.0]];
    
	[label setText:navItem.title];
	[navItem setTitleView:label];
    
    [self setInterface];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setNavItem:nil];
    [self setBotRet:nil];
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
    //maneira errada da certo
    //[[self parentViewController] dismissModalViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
   
}
@end
