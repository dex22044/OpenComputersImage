PImage img;
OutputStream os;

void setup(){
  size(1280,720);
  img=loadImage("botw.png");
  double proport=img.width/img.height;
  img.resize(160,100);
  os=createOutput("botw.ocif");
}
int i=0;
void draw(){
  try{
    os.write((char)img.width);
    os.write((char)img.height);
  }catch(Exception e){}
  for(int y=0;y<img.height;y+=2)
    for(int x=0;x<img.width;x++){
      println(x+"\t"+y);
      color col=img.get(x,y);
      color col2=img.get(x,y+1);
      fill(col);
      rect(0,0,width,height/2);
      
      fill(col2);
      rect(0,height/2,width,height/2);
      try{
        os.write((char)red(col));
        os.write((char)green(col));
        os.write((char)blue(col));
        
        os.write((char)red(col2));
        os.write((char)green(col2));
        os.write((char)blue(col2));
      }catch(Exception e){}
    }
  try{os.close();}catch(Exception e){}
  exit();
}

int c24toc8(int r,int g,int b){
  int encodedData = (floor((r / 32)) << 5) + (floor((g / 32)) << 2) + floor((b / 64));
  return encodedData;
}
