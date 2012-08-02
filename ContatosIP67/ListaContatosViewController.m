//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios2984 on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "ListaContatosViewController.h"
#import "FormularioContatoViewConroller.h"
#import <Twitter/TWTweetComposeViewController.h>
@implementation ListaContatosViewController
@synthesize contatos;

#pragma mark - Métodos de apoio

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
    f.delegate = self;
    f.contatos = [self contatos];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:f];
// -- Transição
//    [f setModalTransitionStyle: UIModalTransitionStyleCrossDissolve ];
    [self presentModalViewController:nav animated:YES];
    
}

-(void) abrirAplicativoComUrl:(NSString *) url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - Acões do Usuário

-(void)ligar{
    UIDevice *device = [UIDevice currentDevice];
    if ([device.model isEqualToString:@"iPhone"]) {
        NSString *numero = [NSString stringWithFormat:@"tel:%@", contatoSelecionado.telefone];
        [self abrirAplicativoComUrl:numero];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Impossível fazer a ligação" message:@"Seu dispositivo não é um iPhone" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles: nil] show];
    }
}

-(void)enviarEmail{
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *enviadorEmail = [[MFMailComposeViewController alloc] init];
        [enviadorEmail setMailComposeDelegate: self];
        [enviadorEmail setToRecipients:[NSArray arrayWithObject:contatoSelecionado.email]];
        [enviadorEmail setSubject:@"Caelum"];
        [self presentModalViewController:enviadorEmail animated:YES];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ops!" message:@"Nao pode enviar email" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles: nil];
        [alert show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)abrirSite{
    NSString * url = [NSString stringWithFormat:@"http://%@", contatoSelecionado.site];
    [self abrirAplicativoComUrl:url];
}

-(void)abrirMapa{
    NSString * url = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.endereco];
    [self abrirAplicativoComUrl:url];
}

-(void)enviarTweet{
    TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc] init];
    [tweet setInitialText: [NSString stringWithFormat:@"@%@", contatoSelecionado.twitter]];
    [self presentModalViewController:tweet animated:YES];
}

#pragma mark - Construtores

- (id)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = NSLocalizedString(@"contatos", nil);
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] 
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(exibeFormulario)];
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        [[self navigationItem] setLeftBarButtonItem:self.editButtonItem];
    }
    return self;
}

#pragma mark - TableView

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Contato *tempContato = [self.contatos objectAtIndex:sourceIndexPath.row];
    [self.contatos removeObjectAtIndex:sourceIndexPath.row];
    [self.contatos insertObject:tempContato atIndex:destinationIndexPath.row];
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
    [[cell textLabel] setFont: [UIFont systemFontOfSize:14]];

    return cell;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[self tableView] reloadData];
}


-(void)tableView:(UITableView *)tableView
            commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
            forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contatos removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Contato *c = [self.contatos objectAtIndex:indexPath.row];
    FormularioContatoViewConroller *form = [[FormularioContatoViewConroller alloc] initWithContato:c ];
    form.delegate = self;
    form.contatos = self.contatos;
    [self.navigationController pushViewController:form animated:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer: longPress];
}

#pragma mark - Status do contato

-(void)contatoAtualizado:(Contato *)contato{
    NSLog(@"Atualizado: %d", [self.contatos indexOfObject:contato]);
}
-(void)contatoAdicionado:(Contato *)contato{
    NSLog(@"Adicionado: %d", [self.contatos indexOfObject:contato]);
}

#pragma mark - Gestos
-(void)exibeMaisAcoes:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        Contato *contato = [contatos objectAtIndex:index.row];
        contatoSelecionado = contato;
        UIActionSheet *opcoes = [[UIActionSheet alloc]
                                 initWithTitle:contato.nome
                                 delegate:self
                                 cancelButtonTitle:@"Cancelar"
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar Site", @"Abrir Mapa", @"Tweetar", nil];
        [opcoes showInView:self.view];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self abrirMapa];
            break;
        case 4:
            [self enviarTweet];
            break;
        default:
            break;
    }
}


#pragma mark - Memória

-(void) dealloc{
    self.contatos = nil;
}
@end
