//  Created by Sir Cheshire

#import "LogicCore.h"

@implementation LogicCore

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    
        [self setDocs:[self loadList]];
        passFile = @"senha.txt";
        tryFile = @"try.txt";
        agreedFile = @"agreed.txt";
        updatedFile = @"updated.txt";
        purgeFile = @"purge.txt";
        docsFile = @"docs.txt";   
    }
    
    return self;
}

+(BOOL) loadGreed
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"agreed.txt"]];
    
    NSString* getback = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    
    if ([getback isEqualToString:@"YES3"]) 
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(void) saveAgreed
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);     
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"agreed.txt"]]; 
    
    NSData* file = [@"YES3" dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileManager createFileAtPath:fullPath contents:file attributes:nil];
}

-(void) update:(BOOL)test
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if (test) 
    {
        NSArray* temp = [NSMutableArray new];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"documentos.txt"]];
        
        NSString* getback = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
        
        temp = [getback componentsSeparatedByString:@"+ +"];
        
        [self saveList:[NSArray new]];
        
        for (NSString * s in temp) 
        {
            [self insertDoc:s];
            
            UIImage* front = [UIImage imageWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@F.png",s]]];
            
            UIImage* back = [UIImage imageWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@V.png",s]]];
            
            if (front != nil) 
            {
                
                [LogicCore saveImage:front toDoc:s];
                
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@F.png", s]];
                
                [fileManager removeItemAtPath: fullPath error:nil];
            }
            
            if (back != nil) 
            {
                
                [LogicCore saveImage:back toDoc:s];
                
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@V.png", s]];
                
                [fileManager removeItemAtPath: fullPath error:nil]; 
            }
        }
    }
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"updated.txt"]]; 
    
    NSData* file = [@"YES" dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileManager createFileAtPath:fullPath contents:file attributes:nil];
}

+(BOOL) isUpdated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"updated.txt"]];
    
    NSString* getback = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    
    if ([getback isEqualToString:@"YES"]) 
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void) purge
{
    for (NSString * s in [self getDocs]) 
    {
        [self deleteDoc:s];
    }
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:docsFile];
    
    [fileManager removeItemAtPath: fullPath error:nil];
    
    fullPath = [documentsDirectory stringByAppendingPathComponent:passFile];
    
    [fileManager removeItemAtPath: fullPath error:nil];
    
    fullPath = [documentsDirectory stringByAppendingPathComponent:purgeFile];
    
    [fileManager removeItemAtPath: fullPath error:nil];
    
    fullPath = [documentsDirectory stringByAppendingPathComponent:tryFile];
    
    [fileManager removeItemAtPath: fullPath error:nil];
    
    fullPath = [documentsDirectory stringByAppendingPathComponent:agreedFile];
    
    [fileManager removeItemAtPath: fullPath error:nil];
    
    fullPath = [documentsDirectory stringByAppendingPathComponent:updatedFile];
    
    [fileManager removeItemAtPath: fullPath error:nil];
    
}

-(BOOL) insertDoc:(NSString*) nome
{    
    [self setDocs:[self loadList]];  
    
    if ([docs containsObject:nome]) 
    {
        return NO;
    }

    [docs insertObject:nome atIndex:[docs count]];
        
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
        
        //
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", nome]];
        
    [[NSMutableArray new] writeToFile:fullPath atomically:NO];
        
    [self saveList:docs];
    
    return YES;
    
}

-(void) deleteDoc:(NSString *)nome
{
    [docs removeObject:nome]; 

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", nome]];
    
    NSMutableArray* temp = [NSMutableArray arrayWithContentsOfFile:fullPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:fullPath error:nil];
    
    for (NSString * s in temp) 
    {
        NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:s];
        
        [fileManager removeItemAtPath:fullPath error:nil];
    }
    
    [self saveList:docs];
}

- (void)removeImage:(int)index fromDoc:(NSString*)doc
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", doc]];
    
    NSMutableArray* temp = [NSMutableArray arrayWithContentsOfFile:fullPath];
    
    NSString* fileName = [temp objectAtIndex:index];
    
    [temp removeObjectAtIndex:index];
    
    [temp writeToFile:fullPath atomically:NO];
    
    fullPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [fileManager removeItemAtPath: fullPath error:nil];
}

- (void)saveList: (NSArray*)documentos 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);     
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:docsFile]; 
    
    [documentos writeToFile:fullPath atomically:NO];  
}

-(NSArray*)loadList
{  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:docsFile];
    
    
    return [NSMutableArray arrayWithContentsOfFile:fullPath];   
}

+ (void)savePass: (NSString*)pass 
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);     
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"senha.txt"]]; 
    
    NSData* file =[pass dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileManager createFileAtPath:fullPath contents:file attributes:nil]; 
}

+ (NSString*)loadPass
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"senha.txt"]];
    
    NSString* getback = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    
    if ([getback length] < 4) {
        getback = [[NSString alloc] initWithString:@""];
    }
    
    return getback;    
}

+(void) clearTry
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);     
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"try.txt"]]; 
    
    NSString* totalTries = [NSString stringWithFormat:@"%d", 0];
    
    NSData* file =[totalTries dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileManager createFileAtPath:fullPath contents:file attributes:nil]; 
}

+ (BOOL)saveTry 
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);     
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"try.txt"]]; 
    
    NSString* totalTries = [NSString stringWithFormat:@"%d", [LogicCore loadTry]+1];
    
    NSData* file =[totalTries dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileManager createFileAtPath:fullPath contents:file attributes:nil]; 
    
    BOOL ret = ([LogicCore loadTry] >9) ? YES : NO;
    
    return ret;
}

+ (int)loadTry
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"try.txt"]];
    
    NSString* getback = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    
    return [getback integerValue];    
}

- (void)savePurge: (BOOL)purge 
{
    
    NSString* purgeString;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
 
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:purgeFile]; 
      
    purgeString = (purge) ? [[NSString alloc] initWithString:@"YES"] : [[NSString alloc] initWithString:@"NO"];
      
    
    
    NSData* file = [purgeString dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:fullPath contents:file attributes:nil];
 
}

- (BOOL)loadPurge
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:purgeFile];
    
    NSString* getback = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    
  
    
    if ([getback isEqualToString:@""] || getback == nil) 
    {
       
        return NO;
    }
    
    BOOL ret = ([getback isEqualToString:@"YES"]) ? YES : NO;
    
    return ret;
    
}

+ (void)saveImage:(UIImage*)image toDoc:(NSString*)doc 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 

    //
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", doc]];

    NSMutableArray* temp = [NSMutableArray arrayWithContentsOfFile:fullPath];
    
    NSString* append = [NSString stringWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"docCount.txt"]] encoding:NSUTF8StringEncoding error:nil];
    
    int count = [append intValue];
    
    count++;
    
    append = [NSString stringWithFormat:@"%d",count];
    
    [append writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"docCount.txt"]] atomically:NO encoding:NSUTF8StringEncoding error:nil];
    
    NSString* imgName = [NSString stringWithFormat:@"%@_%@.png", doc,append];
    
    [temp insertObject:imgName atIndex:[temp count]];
    
    [temp writeToFile:fullPath atomically:NO];
    
    //
    fullPath = [documentsDirectory stringByAppendingPathComponent:imgName];
    
    [UIImagePNGRepresentation(image) writeToFile:fullPath atomically:NO];
}

+ (NSMutableArray*)loadImagesfromDoc:(NSString*)doc
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", doc]];
    
    NSMutableArray* temp = [NSMutableArray arrayWithContentsOfFile:fullPath];
    
    NSMutableArray* ret = [NSMutableArray new];
    
    for (NSString * s in temp) 
    {
        fullPath = [documentsDirectory stringByAppendingPathComponent:s];
        
        UIImage* temp = [UIImage imageWithContentsOfFile:fullPath];

        if (temp) 
        {

            [ret insertObject:temp atIndex:[ret count]];
        }
        else
        {
            NSLog(@"nulo. não inseriu");
        }
    }
    
    return  ret;
}

-(NSArray*) getDocs
{    
    [self setDocs:[self loadList]];
    
    return [docs copy];
}

-(void) setDocs:(NSArray*) lista
{
    docs = [[NSMutableArray alloc] initWithArray:lista]; 
    
    for (int i = 0; i < [docs count]; i++) 
    {
        NSString* s = [docs objectAtIndex:i];
        
        if ([s length] == 0) 
        {
            [docs removeObject:s];
        }
    }
}


@end
