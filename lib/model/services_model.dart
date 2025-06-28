class ServicesModel{
  String image;
  String name;
  ServicesModel({required this.image,required this.name});
 static List<ServicesModel> getServices(){
    return [
      ServicesModel(image: 'assets/shaving.png', name: "Classic Shaving"),
      ServicesModel(image: 'assets/cutting.png', name: "Hair Cutting"),
      ServicesModel(image: 'assets/hair.png', name: "Hair Washing"),
      ServicesModel(image: 'assets/kids.png', name: "Kid Hair Cutting"),
      ServicesModel(image: 'assets/facials.png', name: " Fascials"),
      ServicesModel(image: 'assets/beard.png', name: "Beard Trimming"),
    ];
  }
}