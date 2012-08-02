//
//  FormularioContatoViewConroller.m
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoViewConroller.h"

@implementation FormularioContatoViewConroller : UIViewController
@synthesize spinner;

@synthesize nome, telefone, email, endereco, site, contatos, contato, delegate, twitter, botaoFoto, latitude, longitude, campoAtual, tamanhoInicialDoScroll;

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
    
    if(botaoFoto.imageView.image)
    {
        contato.foto = botaoFoto.imageView.image;
    }

    contato.nome = nome.text;
    contato.email = email.text;
    contato.telefone = telefone.text;
    contato.endereco = endereco.text;
    contato.site = site.text;
    contato.twitter = twitter.text;
    contato.latitude = [NSNumber numberWithFloat:[latitude.text floatValue]];
    contato.longitude = [NSNumber numberWithFloat:[longitude.text floatValue]];
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
        UIActionSheet *sheet = [[UIActionSheet alloc]
                                initWithTitle:@"Escolha a foto do contato"
                                delegate: self
                                cancelButtonTitle:@"Cancelar"
                                destructiveButtonTitle:nil
                                otherButtonTitles:@"Tirar foto", @"Escolher da Biblioteca", nil];
        [sheet showInView:self.view];
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

#pragma mark - Scrool

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    campoAtual = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    campoAtual = nil;
}

-(void)tecladoApareceu:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGRect areaDoTeclado = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGSize tamanhoDoTeclado = areaDoTeclado.size;
    UIScrollView *scroll = (UIScrollView *) self.view;
    UIEdgeInsets margens = UIEdgeInsetsMake(0.0, 0.0, tamanhoDoTeclado.height, 0.0);
    scroll.contentInset = margens;
    scroll.scrollIndicatorInsets = margens;
    
    if(campoAtual)
    {
        CGFloat alturaEscondida = tamanhoDoTeclado.height + self.navigationController.navigationBar.frame.size.height;
        CGRect tamanhoDaTela = scroll.frame;
        tamanhoDaTela.size.height = alturaEscondida;
        
        BOOL campoAtualSumiu = !CGRectContainsPoint(tamanhoDaTela, campoAtual.frame.origin);
        if(campoAtualSumiu){
            CGFloat tamanhoAdicional = tamanhoDoTeclado.height - self.navigationController.navigationBar.frame.size.height;
            CGPoint pontoVisivel = CGPointMake(0.0, campoAtual.frame.origin.y - tamanhoAdicional);
            [scroll setContentOffset:pontoVisivel animated:YES];
            
            CGSize scrollContentSize = scroll.contentSize;
            scrollContentSize.height += alturaEscondida + campoAtual.frame.size.height;
            scroll.contentSize = scrollContentSize;
        }
    }
}
-(void) tecladoSumiu:(NSNotification *)notification{
    UIScrollView *scroll = (UIScrollView *) self.view;
    scroll.contentSize = tamanhoInicialDoScroll;
    [scroll setContentOffset: CGPointZero animated:YES];
}


#pragma mark - GeoCode

-(IBAction)buscarCoordenadas:(id)sender{
    [sender setHidden:YES];
    [spinner startAnimating];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:endereco.text completionHandler:
     ^(NSArray *resultados, NSError *error){
         if(error == nil && resultados.count > 0){
             CLPlacemark *resultado = [resultados objectAtIndex:0];
             CLLocationCoordinate2D coordenada = resultado.location.coordinate;
             latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
             longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
         }
         [spinner stopAnimating];
         [sender setHidden:NO];
     }];
}

#pragma mark - Construtores e inicializadores

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
        latitude.text = [contato.latitude stringValue];
        longitude.text = [contato.longitude stringValue];
        if(contato.foto)
        {
            [botaoFoto setImage:contato.foto forState: UIControlStateNormal];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tecladoApareceu:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tecladoSumiu:)
                                                 name:UIKeyboardDidHideNotification object:nil];
    tamanhoInicialDoScroll = self.view.frame.size;
}

#pragma mark - Gerencia de Memoria
-(void) dealloc{
    self.contatos = nil;
}

- (void)viewDidUnload {
    [self setBotaoFoto:nil];
    [self setLatitude:nil];
    [self setLongitude:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
}
@end
