class ServicesModel{
  String image;
  String name;
  ServicesModel({required this.image,required this.name});
  List<ServicesModel> getServices(){
    return [
      ServicesModel(image: image, name: name)

    ];
  }
}