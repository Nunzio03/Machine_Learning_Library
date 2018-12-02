public static class Matrix{

  int rows;
  int cols;
  double[][] data;

  public Matrix(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
    this.data = new double[rows][cols];
  }

  public void setData(double[][] newData){
    this.data = newData;
  }

  public void randomize(){
    for(int i=0; i<rows; i++){
      for(int j=0; j<cols; j++){
        data[i][j] = Math.random()*2-1;
      }
    }
  }

  public void multiply(double n){
    for(int i=0; i<rows; i++){
      for(int j=0; j<cols; j++){

        data[i][j] = data[i][j] * n;
      }
    }
  }

  public void add(double n){
    for(int i = 0; i < this.rows; i++){
      for(int j = 0; j < this.cols; j++){
        this.data[i][j] += n;
        }
      }
    }

  public void add(Matrix m){
    for(int i = 0; i < this.rows; i++){
      for(int j = 0; j < this.cols; j++){
        this.data[i][j] += m.data[i][j];
      }
    }
  }

  public void map(MapFunction f){
    for(int i=0; i<rows; i++){
      for(int j=0; j<cols; j++){

        data[i][j] = f.elaborateMapping(data[i][j]);
      }
    }

  }

  public double[] toArray(){
    double[] arr = new double[this.rows*this.cols];
    int k=0;
    for(int i=0; i<this.rows; i++){
      for(int j=0; j<this.cols; j++){
        arr[k] = this.data[i][j];
        k++;
      }
    }
    return arr;
  }


//STATIC METHODS
 public static Matrix multiply(Matrix m1, Matrix m2) {

  if(m1.cols == m2.rows){
    Matrix result = new Matrix(m1.rows, m2.cols);

    for(int i = 0; i < result.rows; i++){
      for(int j = 0; j < result.cols; j++){

        double sum = 0;
        for(int k = 0; k < m1.cols; k++){
          sum += m1.data[i][k] * m2.data[k][j];
        }
        result.data[i][j] = sum;
      }
    }
    return result;

  }else{
    System.err.println("error, cols must be equal to rows ");
    return new Matrix(0,0);
  }
  }


  public static Matrix fromArray(double[] arr){
    Matrix m = new Matrix(arr.length, 1);

    for(int i=0; i<arr.length; i++){
      m.data[i][0] = arr[i];
    }
    return m;

  }



//UTILITIES

  public Matrix copy(){
    Matrix newCopy = new Matrix(this.rows, this.cols);
    newCopy.randomize();
    newCopy.multiply(0);
    newCopy.add(this);
    return newCopy;
  }

  public void print(){
    for(int i=0; i<rows; i++){
      System.out.println("");
      for(int j=0; j<cols; j++){
        System.out.print(" "+data[i][j]+" ");

      }
    }
    System.out.println("");
  }


}
