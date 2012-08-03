//
//  Contato.h
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Contato : NSObject <NSCoding, MKAnnotation>
@property(nonatomic, strong) NSString *nome, *email, *telefone, *endereco, *site, *twitter;
@property(nonatomic, strong) NSNumber *latitude, *longitude;
@property(strong) UIImage *foto;
@end
