//
//  AppDelegate.m
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FormularioContatoViewConroller.h"
#import "ListaContatosViewController.h"
#import "ContatosNoMapaViewController.h"

@implementation AppDelegate

@synthesize window = _window, contatos, arquivoContatos, contexto = _contexto;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    // Carregamento dos contatos do arquivo
    NSArray *usersDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *documentDir = [usersDirs objectAtIndex:0];
    self.arquivoContatos = [NSString stringWithFormat:@"%@/ArquivoContatos", documentDir];
    
    // Listagem de Contatos
    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.arquivoContatos];
    if(!self.contatos){
        self.contatos = [[NSMutableArray alloc] init ];
    }
    
    ListaContatosViewController *lista = [[ListaContatosViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lista];

    [lista setContatos: [self contatos]];
    
    // Mostrando localização no mapa
    ContatosNoMapaViewController *contatosMapa = [[ContatosNoMapaViewController alloc] init];
    
    [contatosMapa setContatos:contatos];
    UINavigationController *mapaNavigation = [[UINavigationController alloc]
                                              initWithRootViewController:contatosMapa];
    
    
    // Tabs
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:nav, mapaNavigation, nil];
    
    // View
    [[self window] setRootViewController: tabBarController];
    [[self window] setBackgroundColor: [UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    return YES;
    
}

// CoreData

-(NSURL *) applicationDocumentDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDirectory]lastObject];
}

-(NSManagedObjectModel *)managedObjectModel{
    NSURL *modelUrl = [[NSBundle mainBundle]
                       URLForResource:@"ModelContatos"
                       withExtension:@"momd"];
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    
    return managedObjectModel;
}

-(NSPersistentStoreCoordinator *)coodinator{
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *pastaDocuments = [self applicationDocumentDirectory];
    NSURL * localBancoDeDados = [pastaDocuments URLByAppendingPathComponent:@"Contatos.sqlite"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:localBancoDeDados options:nil error:nil];
    
    return coordinator;
}

-(NSManagedObjectContext *)contexto{
    if(_contexto){
        return _contexto;
    }
    NSPersistentStoreCoordinator *coordinator = [self coodinator];
    _contexto = [[NSManagedObjectContext alloc] init];
    [_contexto setPersistentStoreCoordinator:coordinator];
    return _contexto;
}

// ----------------------------------------------------------------------------------------

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
