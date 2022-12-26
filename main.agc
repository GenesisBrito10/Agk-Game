
// Project: JogoIFG 
// Created: 2022-05-14

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "PonDog's" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 165, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts


Type valoresDog
//VALORES GLOBAIS PARA O PERSONAGEM
x as float
y as Float
sprite as Integer
velocidade as float
movimento as Integer
ultmovimento as Integer
placar as Integer

EndType

Type valoresBola
	//VALORES GLOBAIS PARA A BOLA
	
	x as float
	y as float
	sprite as float
	velocidade as float
	moverX as float
	moverY as float
	esquerda as integer
	EndType

	
Global bola as valoresBola
Global paraEsquerda as integer


//SOM

LoadMusic (1, "som.wav" )
PlayMusic(1,1)



	
		


//BACKGROUND
Global fundo = 3
LoadImage(fundo,"sammie-cabrera-thumb.jpg")
CreateSprite(fundo,fundo)


//BOLA
Global imgbola = 2
LoadImage(imgbola,"ball.png")
bola.sprite = 5
bola.x = 500
bola.y=340
CreateSprite(bola.sprite,imgbola)
SetSpritePosition(bola.sprite,bola.x,bola.y)


//PERSONAGEM
Global dog as valoresDog
Global imgdog = 1
LoadImage(imgdog,"dog.png")
dog.x=512 
dog.y=590
dog.sprite = 6
dog.velocidade=15
CreateSprite(dog.sprite,imgdog)
SetSpritePosition(dog.sprite,dog.x,dog.y)






//VELOCIDADE E SPAW ALEATORIO DA BOLA

bola.moverY = RandomSign(1)
bola.moverX = RandomSign(1)
bola.velocidade=5
bola.esquerda = 5


Function controlardog()
	
	//PRA MEXER O BONECO COM AS TECLAS "A" E "D"
	
	if GetRawKeyState(65)= 1
		
		Dec dog.x,dog.velocidade
		dog.movimento=2
		dog.ultmovimento=GetMilliseconds()
	EndIf
	
	if GetRawKeyState (68) = 1
		Inc dog.x,dog.velocidade
		dog.movimento=2
		dog.ultmovimento =GetMilliseconds()
	EndIf	
	
	If dog.x < 0
		dog.x = 0
		EndIf
		
	If dog.x > 900
		dog.x = 900
		EndIf	
	
	
	
	SetSpritePosition(dog.sprite,dog.x,dog.y)
	
	//if GetMilliseconds() - dog.ultmovimento > 
		//dog.ultmovimento=0
		//endif
		
	//PRA TER COLISAO DO PERSONAGEM COM A BOLA
	
	if GetSpriteCollision(dog.sprite,bola.sprite)= 1
		bola.moverY = -bola.moverY
		Inc bola.velocidade,0.2
		Inc dog.placar,1 	
		/*if dog.ultmovimento > 0 and GetRawKeyState(65)= 1
			bola.moverX= -dog.ultmovimento
			endif
	if dog.ultmovimento > 0 and GetRawKeyState(68)= 1
		bola.moverX = dog.ultmovimento		
		endif*/
	
	endif	
	
	
	
EndFunction	

Function moverbola()
	
	//PRA BOLA BATER NA BORDA E IR PRO MEIO
	bola.x = bola.x + bola.moverX * bola.velocidade
	bola.y = bola.y + bola.moverY * bola.velocidade
	SetSpritePosition(bola.sprite,bola.x,bola.y)
	
	if bola.y < 8 
		bola.moverY = -bola.moverY
		Endif
		
		if bola.x < 0 or bola.x > 980
			bola.moverX = -bola.moverX
			endif
			
	if bola.y > 800
		bola.esquerda = 1
		paraEsquerda = paraEsquerda + 1
	endif	
	
	
	//Bola voltar para o incio
	if bola.esquerda = 1 or bola.esquerda = 2
		bola.esquerda = -1
		bola.moverX = RandomSign(1)
		bola.moverY = RandomSign (1)
		bola.velocidade = 4
		bola.x = 500
		bola.y = 340
		
	SetSpritePosition(bola.sprite,bola.x,bola.y)
	endif
	
	if paraEsquerda = 1
		
		/*LoadFont(1,"Gamer.ttf")
		
		CreateText(2,"GAME OVER !!")
		SetTextFont(2,1)
		SetTextSize(2,100)
		SetText
		
		
		
		SetTextAlignment(2,1)
		SetTextPosition(2,500,300)
		
		SetTextColor(2,253,253,0,255)
		SetTextBold(2,1)*/
		
		LoadImage(5,"gameover.png")
		CreateSprite(1,5)
		SetSpritePosition(1,225,250)
		
		paraEsquerda = 0
		bola.velocidade = 0
		
		endif
		
		
	
	
	
	
			
		
endfunction
/*CreateText(3,"Placar:")
SetTextPosition(3,1,10)
SetTextSize(3,65)*/

LoadImage(8,"menu.png")

LoadImage(6,"placar2.png")
CreateSprite(2,6)
SetSpritePosition(2,1,-50)
//SetTextPosition(3,1,10)

LoadImage(7,"quadro.png")
CreateSprite(4,7)
SetSpritePosition(4,210,-3)

LoadFont(1,"DS-Digi.ttf")
CreateText(4,"0")
SetTextFont(4,1)
SetTextColor(4,0,0,0,255)
SetTextPosition(4,300,25)
SetTextSize(4,60)





		






Function placar ()
	Local change$
	change$ = str(dog.placar)
	SetTextString(4,change$)
	EndFunction
	
	function menu ()
	
	
	LoadImage(10,"menu.png")
	CreateSprite(12,10)
	
	if GetRawKeyPressed(32)= 1
		DeleteSprite(12)
		sair = 3
		
		exit
		endif
		
	endfunction
	




menu()
do

		
		
		
		
		
		controlardog()
		moverbola()
		placar()
		
		
		
		
		
	

    
    
	
    
    Sync()
loop
