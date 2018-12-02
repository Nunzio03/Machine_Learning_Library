public class MapFunction{

String name;

public MapFunction(String name){
  this.name = name;

}

public double elaborateMapping(double n){

  switch(name){
    case "doubleIt":
      return n*2;
    case "sigmoid":
      return 1/(1+Math.exp(-n));
    case "binary":
      if(n>0.5){
        return 1;
      }else{
        return 0;
      }
    default:
      return n;

  }
}



}
