public class NeuralNetwork{
  int in_nodes;
  int h_nodes;
  int o_nodes;
  Matrix weights_ih;
  Matrix weights_ho;
  Matrix bias_h;
  Matrix bias_o;


  public NeuralNetwork(int in_nodes, int h_nodes, int o_nodes){
    this.in_nodes = in_nodes;
    this.h_nodes = h_nodes;
    this.o_nodes = o_nodes;

    this.weights_ih = new Matrix(this.h_nodes, this.in_nodes);
    this.weights_ho = new Matrix(this.o_nodes, this.h_nodes);
    this.bias_h = new Matrix(this.h_nodes, 1);
    this.bias_o = new Matrix(this.o_nodes, 1);

    weights_ih.randomize();
    weights_ho.randomize();
    bias_h.randomize();
    bias_o.randomize();

  }

  public NeuralNetwork(Matrix ih_w, Matrix ho_w, Matrix h_b, Matrix o_b){
    this.in_nodes = ih_w.cols;
    this.h_nodes = ih_w.rows;
    this.o_nodes = ho_w.rows;

    this.weights_ih = ih_w;
    this.weights_ho = ho_w;
    this.bias_h = h_b;
    this.bias_o = o_b;



  }

  public double[] feedforward(double[] input){
    MapFunction squash = new MapFunction("sigmoid");
    MapFunction binary = new MapFunction("binary");
    Matrix inputs = Matrix.fromArray(input);

    Matrix hidden = Matrix.multiply(weights_ih, inputs);
    hidden.add(this.bias_h);
    hidden.map(squash);

    Matrix output = Matrix.multiply(weights_ho, hidden);
    output.add(this.bias_o);
    output.map(squash);
    output.map(binary);

    return output.toArray();


  }

  public NeuralNetwork copy(){
    NeuralNetwork newCopy = new NeuralNetwork(this.in_nodes, this.h_nodes, this.o_nodes);
    newCopy.weights_ih = this.weights_ih.copy();
    newCopy.weights_ho = this.weights_ho.copy();
    newCopy.bias_h = this.bias_h.copy();
    newCopy.bias_o = this.bias_o.copy();

    return newCopy;
  }


  public void mutate(double mutationRate){
    for(int i=0; i<h_nodes; i++){
      for(int j=0; j<in_nodes; j++){
        if(random(1)<mutationRate){
          weights_ih.data[i][j] = Math.random()*2-1;
        }
      }
    }

    for(int i=0; i<o_nodes; i++){
      for(int j=0; j<h_nodes; j++){
        if(random(1)<mutationRate){
          weights_ho.data[i][j] = Math.random()*2-1;
        }
      }
    }

    for(int i=0; i<h_nodes; i++){
      for(int j=0; j<1; j++){
        if(random(1)<mutationRate){
          bias_h.data[i][j] = Math.random()*2-1;
        }
      }
    }

    for(int i=0; i<o_nodes; i++){
      for(int j=0; j<1; j++){
        if(random(1)<mutationRate){
          bias_o.data[i][j] = Math.random()*2-1;
        }
      }
    }

  }

}
