//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by ios2984 on 02/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>

@interface ContatosNoMapaViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) NSMutableArray *contatos;
@end
