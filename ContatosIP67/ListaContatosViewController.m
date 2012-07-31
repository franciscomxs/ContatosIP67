//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios2984 on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewConroller.h"

@implementation ListaContatosViewController
@synthesize contatos;

-(void)exibeFormulario{
// -- Alerta
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"Contatos"
//                          message:@"E aí velhinho?"
//                          delegate:nil
//                          cancelButtonTitle:@"Cancelar"
//                          otherButtonTitles:nil];
//    [alert show];
    FormularioContatoViewConroller *f = [[FormularioContatoViewConroller alloc] init];
    [f setContatos: [self contatos]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:f];
// -- Transição
//    [f setModalTransitionStyle: UIModalTransitionStyleCrossDissolve ];
    [self presentModalViewController:nav animated:YES];
    
}

- (id)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Contatos";
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] 
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(exibeFormulario)];
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self contatos] count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Contato *contato = [[self contatos] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText: [contato nome]];

    return cell;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[self tableView] reloadData];
}

-(void) dealloc{
    self.contatos = nil;
}

@end
