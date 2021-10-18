HackComputer hackComputer;

void setup(){
  hackComputer = new HackComputer();
  size(512,256);
  background(255,255,255);
  frameRate(15);
  thread("tick");
  if (Default.TESTS) runTests();
  hackComputer.preload("Pong");
  //hackComputer.ram.ram[0] = 223;
}


void draw(){ 
  
  loadPixels();
  
  for(int i=0; i<width; i++) {
    for(int j=0; j<height; j++) {
      int value = hackComputer.ram.readPixel(i, j);
      pixels[i+j*width] = color(value==1 ? 0 : 255);
    }
  }
  
  updatePixels();
}

void mouseClicked() {
  println("Cycle");
  hackComputer.cycle();
  println("pc: " + hackComputer.cpu.pc);
  println("registerA: " + hackComputer.cpu.registerA);
  println("writeM: " + hackComputer.cpu.writeM);
  println("registerD: " + hackComputer.cpu.registerD);
  print("[");  
  for(int i=0; i<35; i++) {
    print(hackComputer.ram.ram[i] + ", ");
  }
  println("]\n");
}

void keyPressed() {
  println(key + "  _  " + Default.KBDscancode(key));
}

void tick() {
  while(true) {
    for(int j=0; j<Default.MHZ*1000;j++) {
      //println("Cycle");
      //hackComputer.cycle();
    }
    delay(1);
  }
}

void runTests() {
  new RAMTest().test();
  new ROMTest().test();
  new ALUTest().test();
  new PCTest().test();
  new PCControllerTest().test();
  new CPUTest().test();
  new InstructionTest().test();
}
