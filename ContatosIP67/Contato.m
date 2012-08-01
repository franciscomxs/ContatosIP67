//
//  Contato.m
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contato.h"

@implementation Contato
@synthesize nome = _nome;
@synthesize email = _email;
@synthesize telefone = _telefone;
@synthesize endereco = _endereco;
@synthesize site = _site;

-(void)setNome:(NSString *)nome{
    if(nome.length > 0){
        _nome = nome;   
    }
    else{
        _nome = [NSString stringWithFormat: @"NOME VAZIO %i", rand()];
    }
}

-(void)setEmail:(NSString *)email{
    if(email.length > 0){
        _email = email;
    }
    else{
        _email = @"NÃO TEM";
    }
}

-(void)setTelefone:(NSString *)telefone{
    if(telefone.length > 0){
        _telefone = telefone;
    }
    else{
        _telefone = @"NÃO TEM";
    }
}

-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.nome forKey:@"nome"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.telefone forKey:@"telefone"];
    [coder encodeObject:self.endereco forKey:@"endereco"];
    [coder encodeObject:self.site forKey:@"site"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if(self){
        [self setNome: [decoder decodeObjectForKey:@"nome"]];
        [self setEmail: [decoder decodeObjectForKey:@"email"]];
        [self setTelefone: [decoder decodeObjectForKey:@"telefone"]];
        [self setEndereco: [decoder decodeObjectForKey:@"endereco"]];
        [self setSite: [decoder decodeObjectForKey:@"site"]];
    }
    
    return self;
}

@end
