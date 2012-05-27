//  Created by Sir Cheshire

#import <Foundation/Foundation.h>

@interface LogicCore : NSObject
{
    NSMutableArray* docs;
    
    NSString* agreedFile;
    NSString* tryFile;
    NSString* purgeFile;
    NSString* docsFile;
    NSString* passFile; 
    NSString* updatedFile;
    
    
    
   
}

-(void) setDocs:(NSArray*) lista;
-(NSArray*) getDocs;

- (void)saveList: (NSArray*)documentos;
- (NSArray*)loadList;

+ (void)saveImage:(UIImage*)image toDoc:(NSString*)doc;
+ (NSMutableArray*)loadImagesfromDoc:(NSString*)doc;

-(void) update:(BOOL)test;
+(BOOL) isUpdated;

-(void) deleteDoc:(NSString*) nome;
-(BOOL) insertDoc:(NSString*) nome;
-(void) purge;
-(void) removeImage:(int)index fromDoc:(NSString*)doc;
+(NSString*) loadPass;
+(void) savePass:(NSString*) pass;
-(BOOL) loadPurge;
-(void) savePurge:(BOOL) purge;
+ (int)loadTry;
+(BOOL) saveTry;
+(void) clearTry;
+(void) saveAgreed;
+(BOOL) loadGreed;

@end
