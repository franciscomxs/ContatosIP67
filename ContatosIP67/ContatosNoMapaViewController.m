//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios2984 on 02/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import <MapKit/MKUserTrackingBarButtonItem.h>

@implementation ContatosNoMapaViewController
@synthesize mapa, contatos;

#pragma mark - Construtores

-(id)init{
    self = [super init];
    if(self){
        UIImage *imageTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imageTabItem tag:0 ];
        self.tabBarItem = tabItem;
        self.navigationItem.title = @"Localização";
    }
    return self;
}

#pragma mark - Ações da View

-(void)viewWillAppear:(BOOL)animated{
    [self.mapa addAnnotations:contatos];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.mapa removeAnnotations:contatos];
}

- (void)viewDidUnload {
    [self setMapa:nil];
    [super viewDidUnload];
}

-(void)viewDidLoad{
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.leftBarButtonItem = botaoLocalizacao;
}
@end
