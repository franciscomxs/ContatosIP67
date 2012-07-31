//
//  FormularioContatoViewConroller.m
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoViewConroller.h"

@implementation FormularioContatoViewConroller : UIViewController
@synthesize nome, telefone, email, endereco, site, contatos;

-(Contato *)pegaDadosFormulario{
    /*
    NSMutableDictionary *dadosDoContato = [[NSMutableDictionary alloc] init ];
    [dadosDoContato setObject:[nome text] forKey:@"nome"];
    [dadosDoContato setObject:[email text] forKey:@"email"];
    [dadosDoContato setObject:[telefone text] forKey:@"telefone"];
    [dadosDoContato setObject:[site text] forKey:@"site"];
    [dadosDoContato setObject:[endereco text] forKey:@"endereco"];
    NSLog(@"dados: %@", dadosDoContato);
    */
    Contato *c = [[Contato alloc] init ];
    c.nome = nome.text;
    c.email = email.text;
    c.telefone = telefone.text;
    c.endereco = endereco.text;
    c.site = site.text;
    return c;
    
}
-(void)criaContato{
    Contato *c = [self pegaDadosFormulario];
    [[self contatos] addObject:c];
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"Adicionado contato: %@", [c nome]);
    NSLog(@"Contatos: %i", [[self contatos] count]);
}

-(void)cancela{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"Total cadastrados: %i", [[self contatos] count]);
}
-(id) init{
    self = [super init];
    if(self){
        UIBarButtonItem *cancela = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Cancela"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(cancela)];
        [[self navigationItem] setLeftBarButtonItem:cancela];
        
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Adiciona"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(criaContato)];
        [[self navigationItem] setRightBarButtonItem:adiciona];
        
    }
    return self;
}

-(void) dealloc{
    self.contatos = nil;
}

@end
