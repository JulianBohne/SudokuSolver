//https://www.youtube.com/watch?v=N41yZsxIsK8

int[][] input = {{0,0,0,4,3,1,0,0,0},
                 {0,0,8,0,0,0,4,0,0},
                 {0,3,0,0,0,0,0,1,0},
                 {2,0,0,0,0,0,0,0,5},
                 {3,0,0,0,6,0,0,0,9},
                 {9,0,0,0,0,0,0,0,2},
                 {0,7,0,0,0,0,0,6,0},
                 {0,0,9,0,0,0,5,0,0},
                 {0,0,0,8,5,3,0,0,0}};
                 

int[][] output = new int[9][9];

void setup(){
  for(int row = 0; row < 9; row ++){
    for(int col = 0; col < 9; col ++){
      output[row][col] = input[row][col];
    }
  }
  
  if(backtracking(0,0)){
    println();
    for(int row = 0; row < 9; row ++){
      if(row%3 == 0 && row != 0) println("---------+---------+---------");
      for(int col = 0; col < 9; col ++){
        if(col%3 == 0 && col != 0){
          print("|");
        }
        print("[" + output[row][col] + "]");
      }
      println();
    }
  }else{
    println("Not possible");
  }
}

boolean backtracking(int x, int y){
  //print("x:"+x+" y:"+y+", ");
  int nX = (x+1)%9;
  int nY = y + x/8;
  if(input[y][x] == 0){
    for(int i = 1; i <= 9; i ++){
      output[y][x] = i;
      if(possible(x, y)){
        if(y == 8 && x == 8) return true;
        if(backtracking(nX, nY)) return true;
      }
    }
    output[y][x] = 0;
    return false;
  }else{
    if(y == 8 && x == 8) return true;
    if(backtracking(nX, nY)) return true;
    return false;
  }
}

boolean possible(int x, int y){
  for(int i = 0; i < 9; i ++){
    if(i != y){
      if(output[y][x] == output[i][x]){
        return false;
      }
    }
  }
  for(int i = 0; i < 9; i ++){
    if(i != x){
      if(output[y][x] == output[y][i]) return false;
    }
  }
  int bigX = x/3;
  int bigY = y/3;
  for(int row = 0; row < 3; row ++){
    for(int col = 0; col < 3; col ++){
      if(bigY*3 + row != y && bigX*3 + col != x){
        if(output[bigY*3 + row][bigX*3 + col] == output[y][x]) return false;
      }
    }
  }
  
  for(int row = y-1; row <= y+1; row ++){
    for(int col = x-1; col <= x+1; col ++){
      if(!(row == y && col == x) && row >= 0 && row < 9 && col >= 0 && col < 9){
        if(output[row][col] == output[y][x]) return false;
      }
    }
  }
  
  return true;
}
