//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios2984 on 02/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import <MapKit/MapKit.h>
#import "Contato.h"

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

#pragma mark - Métodos do GeoLocation

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    static NSString *identifier = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView *) [mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(!pino){
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    else{
        pino.annotation = annotation;
    }
    
    Contato *contato = (Contato *) annotation;
    pino.pinColor = MKPinAnnotationColorGreen;
    pino.canShowCallout = YES;
    if(contato.foto){
        UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        imagemContato.image = contato.foto;
        pino.leftCalloutAccessoryView = imagemContato;
    }
    return pino;
    
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
