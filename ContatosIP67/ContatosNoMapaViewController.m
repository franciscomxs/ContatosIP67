//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios2984 on 02/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContatosNoMapaViewController.h"

@implementation ContatosNoMapaViewController

-(id)init{
    self = [super init];
    if(self){
        UIImage *imageTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imageTabItem tag:0 ];
        self.tabBarItem = tabItem;
    }
    return self;
}

@end
