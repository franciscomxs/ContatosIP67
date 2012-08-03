//
//  Contato.m
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contato.h"

@implementation Contato


//@synthesize nome = _nome;
//@synthesize email = _email;
//@synthesize telefone = _telefone;
//@synthesize endereco = _endereco;
//@synthesize site = _site;
//@synthesize twitter = _twitter;
//@synthesize foto, latitude, longitude;

@dynamic nome, email, telefone, endereco, site, twitter, latitude, longitude;
@synthesize foto;

#pragma mark - Getters do geocoder

-(CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title{
    if(self.nome.length > 0){
        return self.nome;
    }
    else{
        return @"Sem vergonha não tem nome";
    }
    
}
-(NSString *)subtitle{
    if(self.endereco.length > 0){
        return self.endereco; 
    }
    else{
        return @"Sem vergonha sem endereço";
    }
}

#pragma mark - Setters do geocoder

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    self.latitude = [NSNumber numberWithFloat: newCoordinate.latitude];
    self.longitude = [NSNumber numberWithFloat: newCoordinate.longitude];
    
    CLGeocoder *geocode = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue]];
    [geocode reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro!" message:@"Ocorreu algo inesperado." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else{
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            self.endereco = placemark.thoroughfare;
        }
    }];
}

#pragma mark - Métodos Removidos no exercício 17.9

//-(void)encodeWithCoder:(NSCoder *)coder{
//    [coder encodeObject:self.nome forKey:@"nome"];
//    [coder encodeObject:self.email forKey:@"email"];
//    [coder encodeObject:self.telefone forKey:@"telefone"];
//    [coder encodeObject:self.endereco forKey:@"endereco"];
//    [coder encodeObject:self.site forKey:@"site"];
//    [coder encodeObject:self.site forKey:@"tweet_user"];
//    [coder encodeObject:self.foto forKey:@"foto"];
//    [coder encodeObject:self.latitude forKey:@"latitude"];
//    [coder encodeObject:self.longitude forKey:@"longitude"];
//}
//
//-(id)initWithCoder:(NSCoder *)decoder{
//    self = [super init];
//    if(self){
//        [self setNome: [decoder decodeObjectForKey:@"nome"]];
//        [self setEmail: [decoder decodeObjectForKey:@"email"]];
//        [self setTelefone: [decoder decodeObjectForKey:@"telefone"]];
//        [self setEndereco: [decoder decodeObjectForKey:@"endereco"]];
//        [self setSite: [decoder decodeObjectForKey:@"site"]];
//        [self setSite: [decoder decodeObjectForKey:@"tweet_user"]];
//        [self setFoto: [decoder decodeObjectForKey:@"foto"]];
//        [self setLatitude: [decoder decodeObjectForKey:@"latitude"]];
//        [self setLongitude: [decoder decodeObjectForKey:@"longitude"]];
//    }
//    
//    return self;
//}

@end
