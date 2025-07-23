int statoGioco=0, timer=millis(), dimBloccoX=150, dimBloccoZ=150, contColonna=1, contRiga=3;
boolean morte=false, controllomuro=false, vittoria=false, possessochiave=false;

PImage muro;

PFont inizio_fine;
PFont tempo;

PShape chiave, traguardo;

String[] tavola;
int[][] tavolaCase=new int[13][13];

PVector ovest, nord, est, sud, dc, wherePos, whereLook;
PVector direzione, tempDirezione;

void setup()
{
  size(1600, 900, P3D);
  frameRate(60);
  
  muro=loadImage("immagini/muro.jpg");
  textureMode(NORMAL);
  
  inizio_fine=createFont("font/edosz.ttf", 70);
  tempo=createFont("font/arial.ttf", 20);
  
  chiave=loadShape("modelli/source/key.obj");
  traguardo=loadShape("modelli/traguardo/traguardo.obj");
  
  tavola=loadStrings("mappa.csv");
  
  
  ovest = new PVector(0, 0, -1);
  nord = new PVector(1, 0, 0);
  est = new PVector(0, 0, 1);
  sud = new PVector(-1, 0, 0);
  direzione = new PVector(0, 0, 0);
  direzione.set(ovest);
  tempDirezione = new PVector(0, 0, 0);
  wherePos = new PVector(525, 100, 525);
  whereLook = new PVector(525, 100, 525);
  dc = ovest;
}

void draw()
{
  update();
  
  switch(statoGioco)
  {
    case 0:
      background(0);
      
      textFont(inizio_fine);
      text("Premi spazio per iniziare", 428, 480);
      
      timer=millis();
      morte=false;
      
    case 1:
      if(statoGioco==1)
      {
        
        noCursor();
        background(255);
        
        if(morte==true)
        {
          statoGioco=2;
        }
        else if(vittoria==true){
          statoGioco=3;
        }
        else
        {
          for(int i=0; i<13; i++)
          {
            for(int j=0; j<13; j++)
            {
              tavolaCase[i]=int(split(tavola[5+i], ","));          
            }
          }        
          
          translate(0,400);
          
          camera(wherePos.x, wherePos.y, wherePos.z, whereLook.x+direzione.x, whereLook.y, whereLook.z+direzione.z, 0, 1, 0); 
          
          for(int i=0; i<13; i++)
          {
            for(int j=0; j<13; j++)
            {      
              translate(dimBloccoX,0,0);
              switch(tavolaCase[i][j])
              {
                default:                                      
                 
                 break;
                 
                case 1:            
                  beginShape();
                  texture(muro);
                  vertex(300,0,0,0,0);
                  vertex(150,0,0,0,1);
                  vertex(150,0,150,1,1);
                  vertex(300,0,150,1,0);
                  vertex(300,0,0,0,0);
                  endShape();
                  beginShape();
                  texture(muro);
                  vertex(300,300,0,0,0);
                  vertex(150,300,0,0,1);
                  vertex(150,300,150,1,1);
                  vertex(300,300,150,1,0);
                  vertex(300,300,0,0,0);
                  endShape();
                  beginShape();
                  texture(muro);
                  vertex(300,0,0,0,0);
                  vertex(150,0,0,0,1);
                  vertex(150,300,0,1,1);
                  vertex(300,300,0,1,0);
                  vertex(300,0,0,0,0);
                  endShape();
                  beginShape();
                  texture(muro);
                  vertex(150,0,0,0,0);
                  vertex(150,0,150,0,1);
                  vertex(150,300,150,1,1);
                  vertex(150,300,0,1,0);
                  vertex(150,0,0,0,0);
                  endShape();
                  beginShape();
                  texture(muro);
                  vertex(150,0,150,0,0);
                  vertex(300,0,150,0,1);
                  vertex(300,300,150,1,1);
                  vertex(150,300,150,1,0);
                  vertex(150,0,150,0,0);
                  endShape();
                  beginShape();
                  texture(muro);
                  vertex(300,0,150,0,0);
                  vertex(300,0,0,0,1);
                  vertex(300,300,0,1,1);
                  vertex(300,300,150,1,0);
                  vertex(300,0,150,0,0);
                  endShape();
                  
                  break;
                  
                case 2:     
                if(possessochiave==false)
                {
                  pushMatrix();
                  translate(dimBloccoX/2,150,dimBloccoZ/2);
                  translate(dimBloccoX,0,0);  // Translate per centrare nella cella corretta la chiave
                  scale(20);
                  rotateX(300);
                  shape(chiave);
                  popMatrix();
                }
                 
                  break;
                  
                case 3:
                  pushMatrix();
                  translate(dimBloccoX/2,150,dimBloccoZ/2);
                  translate(dimBloccoX,0,0);  // Translate per centrare nella cella corretta la chiave
                  scale(20);
                  rotateX(300);
                  scale(0.06);
                  rotate(300);
                  translate(0,0,-100);
                  shape(traguardo);
                  popMatrix(); 
                  
                  break;
              }               
            }
            translate(-dimBloccoX*13,0,dimBloccoZ);
          }
        }
      }
      
        break;
      
    case 2:     
      camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
      background(0);
      textFont(inizio_fine);
      text("HAI PERSO", 625, 480);
      
        break;
        
    case 3:  
      camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
      background(0);
      textFont(inizio_fine);
      text("HAI VINTO", 625, 480);
      
        break;
  }
}

void update()
{
  if(statoGioco==1)
  {
    if(millis()-timer>60000 && statoGioco==1)
    {
      morte=true;
    }
    if(tavolaCase[contRiga][contColonna]==3 && possessochiave==true){
      vittoria=true;
    }
    if(tavolaCase[contRiga][contColonna]==2){
      possessochiave=true;
    }
  }
}

void keyPressed()
{
  
  if(key==' ' && statoGioco==0)
  {
    statoGioco=1;  
  }
  
  if(key==' ' && morte)
  {
    delay(2000);
    statoGioco=0;    
  }
  
  if(key==' ' && possessochiave==true)
  {
    delay(2000);
    statoGioco=3;    
  } 
  
  if(key == 'd' && dc == ovest)
  {
    dc=nord;
    direzione.set(nord);
  }
  else if(key == 'd' && dc == nord)
  {
    dc=est;   
    direzione.set(est);
  }
  else if(key == 'd' && dc == est)
  {
    dc=sud;         
    direzione.set(sud);
  }
  else if(key == 'd' && dc == sud)
  {
    dc=ovest;
    direzione.set(ovest);
  }
 
  if(key == 'a' && dc == ovest)
  {
    dc=sud;
    direzione.set(sud);
  }
  else if(key == 'a' && dc == sud)
  {
    dc=est;   
    direzione.set(est);
  }
  else if(key == 'a' && dc == est)
  {
    dc=nord;         
    direzione.set(nord);
  }
  else if(key == 'a' && dc == nord)
  {
    dc=ovest;
    direzione.set(ovest);
  }
 
  if(key == 'w')
  {
    if(dc==ovest)
    {
      if(tavolaCase[contRiga-1][contColonna]==1)
      {
         controllomuro=true;
      }
      else
      {
        controllomuro=false;
        contRiga--;
        tempDirezione.set(direzione);
        wherePos.add((direzione.mult(150)));
        direzione.set(tempDirezione);
        whereLook.add((direzione.mult(150)));
        direzione.set(tempDirezione);
      }
    }
       
    if(dc==nord)
    {
      if(tavolaCase[contRiga][contColonna+1]==1)
      {
        controllomuro=true;
      }
      else
      {
        controllomuro=false;
        contColonna++;
        tempDirezione.set(direzione);
        wherePos.add((direzione.mult(150)));
        direzione.set(tempDirezione);
        whereLook.add((direzione.mult(150)));
        direzione.set(tempDirezione);
       }
     }
       
     if(dc==est)
     {
       if(tavolaCase[contRiga+1][contColonna]==1)
       {
         controllomuro=true;
       }
       else
       {
          controllomuro=false;
          contRiga++;
          tempDirezione.set(direzione);
          wherePos.add((direzione.mult(150)));
          direzione.set(tempDirezione);
          whereLook.add((direzione.mult(150)));
          direzione.set(tempDirezione);
       }
     }

     if(dc==sud)
     {
       if(tavolaCase[contRiga][contColonna-1]==1)
       {
         controllomuro=true;
       }
       else
       {
          controllomuro=false;
          contColonna--;
          tempDirezione.set(direzione);
          wherePos.add((direzione.mult(150)));
          direzione.set(tempDirezione);
          whereLook.add((direzione.mult(150)));
          direzione.set(tempDirezione);
        }
     }      
   }

   if(key == 's')
   {
     if(dc==ovest)
     {
       if(tavolaCase[contRiga+1][contColonna]==1)
       {
         controllomuro=true;
       }
       else
       {
         controllomuro=false;
         contRiga++;
         tempDirezione.set(direzione);
         wherePos.add((direzione.mult(-150)));
         direzione.set(tempDirezione);
         whereLook.add((direzione.mult(-150)));
         direzione.set(tempDirezione);
       }
     }
       
     if(dc==nord)
     {
       if(tavolaCase[contRiga][contColonna-1]==1)
       {
         controllomuro=true;
       }
       else
       {
         controllomuro=false;
         contColonna--;
         tempDirezione.set(direzione);
         wherePos.add((direzione.mult(-150)));
         direzione.set(tempDirezione);
         whereLook.add((direzione.mult(-150)));
         direzione.set(tempDirezione);
       }
     }
       
     if(dc==est)
     {
       if(tavolaCase[contRiga-1][contColonna]==1)
       {
         controllomuro=true;
       }
       else
       {
         controllomuro=false;
         contRiga--;
         tempDirezione.set(direzione);
         wherePos.add((direzione.mult(-150)));
         direzione.set(tempDirezione);
         whereLook.add((direzione.mult(-150)));
         direzione.set(tempDirezione);
       }
     }

     if(dc==sud)
     {
       if(tavolaCase[contRiga][contColonna+1]==1)
       {
         controllomuro=true;
       }
       else
       {
         controllomuro=false;
         contColonna++;
         tempDirezione.set(direzione);
         wherePos.add((direzione.mult(-150)));
         direzione.set(tempDirezione);
         whereLook.add((direzione.mult(-150)));
         direzione.set(tempDirezione);
       }
     }
   }
}
     
