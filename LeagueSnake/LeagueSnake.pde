//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.

int x;
int y;

// Add a constructor with parameters to initialize each variable.

Segment(int x, int y){
  
   this.x=x;
   this.y=y;
  }
}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*

Segment snakeHead;
int foodX;
int foodY;
int direction = UP;
int foodEaten = 0;
ArrayList< Segment > tail = new ArrayList< Segment >();



//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  
size(500, 500);
snakeHead = new Segment(250, 250);
frameRate(20);
dropFood();

}

void dropFood() {
  //Set the food in a new random location
foodX = ((int)random(50)*10);
foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  
 background(0,0,0);
 drawFood();
 drawSnake();
 eat();
}

void drawFood() {
  //Draw the food
  fill(#FF0000);
  rect(foodX, foodY, 10, 10);
  move();
  
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(#08FF4B);
  rect(snakeHead.x, snakeHead.y, 10, 10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
for(int i = 0; i<tail.size(); i++){
  rect(tail.get(i).x, tail.get(i).y, 10, 10);
  }
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  tail.add(new Segment(snakeHead.x, snakeHead.y));
  tail.remove(0);
  
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(int i = 0; i<tail.size(); i++){
    if(snakeHead.x==tail.get(i).x && snakeHead.y==tail.get(i).y){
      foodEaten=1;
      tail=new ArrayList< Segment >();
      tail.add(new Segment(snakeHead.x, snakeHead.y));
    }
  }
  
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if(keyCode == UP && direction!=DOWN){
    direction = UP;
  }
  else if(keyCode == DOWN && direction!=UP){
    direction = DOWN;
  }
  
  else if(keyCode == LEFT && direction!=RIGHT){
    direction = LEFT;
  }
  
  else if(keyCode == RIGHT && direction!=LEFT){
    direction = RIGHT;
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
    
  switch(direction) {
  case UP:
    snakeHead.y-=10;
    break;
  case DOWN:
    // move head down here
    snakeHead.y+=10;
    break;
  case LEFT:
   // figure it out 
   snakeHead.x-=10;
    break;
  case RIGHT:
    // mystery code goes here 
    snakeHead.x+=10;
    break;
  }
  
  checkBoundaries();
  
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(snakeHead.x<0){
   snakeHead.x=500;
 }
 
 else if(snakeHead.x>500){
   snakeHead.x=0;
 }
 
 else if(snakeHead.y<0){
   snakeHead.y=500;
 }
 
 else if(snakeHead.y>500){
   snakeHead.y=0;
 }
 
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
if(snakeHead.x==foodX && snakeHead.y==foodY){
  foodEaten++;
  dropFood();
  tail.add (new Segment(snakeHead.x, snakeHead.y));
}

}
