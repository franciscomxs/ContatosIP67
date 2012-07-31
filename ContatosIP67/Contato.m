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
    if(nome){
        _nome = nome;   
    }
    else{
        _nome = @"NOME VAZIO";
    }
}
@end
