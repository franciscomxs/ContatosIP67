//
//  FormularioContatoViewConroller.m
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoViewConroller.h"

@implementation FormularioContatoViewConroller : UIViewController
@synthesize nome, telefone, email, endereco, site, contatos, contato, delegate, twitter, botaoFoto;

#pragma mark - Contatos

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
    if(!self.contato)
    {
        contato = [[Contato alloc] init ];
    }
    
    contato.nome = nome.text;
    contato.email = email.text;
    contato.telefone = telefone.text;
    contato.endereco = endereco.text;
    contato.site = site.text;
    contato.twitter = twitter.text;
    return contato;
    
}
-(void)criaContato{
    Contato * novoContato = [self pegaDadosFormulario];
    [[self contatos] addObject:[self pegaDadosFormulario]];
    [self dismissModalViewControllerAnimated:YES];
    
    if (self.delegate) {
        [self.delegate contatoAdicionado:novoContato];
    }
}

-(void)atualizaContato{
    Contato * contatoAtualizado = [self pegaDadosFormulario];
    if(self.delegate){
        [self.delegate contatoAtualizado:contatoAtualizado];
    }
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)cancela{
    [self dismissModalViewControllerAnimated:YES];
}


-(IBAction)selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
    }
    else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
        
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [botaoFoto setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"Total cadastrados: %i", [[self contatos] count]);
}

#pragma mark - Construtores

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

-(id)initWithContato:(Contato *)_contato{
    self = [super init];
    if(self){
        self.contato = _contato;
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Confirmar"
                                      style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
        
    }
    return self;
}

-(void)viewDidLoad{
    
    if(self.contato)
    {
        nome.text = contato.nome;
        email.text = contato.email;
        telefone.text = contato.telefone;
        endereco.text = contato.endereco;
        site.text = contato.site;
        twitter.text = contato.twitter;
    }
}

#pragma mark - Gerencia de Memoria
-(void) dealloc{
    self.contatos = nil;
}

- (void)viewDidUnload {
    [self setBotaoFoto:nil];
    [super viewDidUnload];
}
@end
