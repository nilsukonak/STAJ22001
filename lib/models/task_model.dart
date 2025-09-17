//TASK İÇİN CLASS

class Taskmodel {
  late String? id; //firestorede her görevn idsi var edistask yaaprken lazm
  late String title;
  late String description;
  late String date;
  late String priority;
  late String category;
  bool isdone;
  Taskmodel({
    this.id,
    required this.title,
    required this.description,
    required this.date, //parametreyi zorunlu tutar ama deegr kontrollerini yapmz yani " " deegr de olblr gorevde
    required this.priority,
    required this.category,
    this.isdone = false, 
  });
  //firebasede her sey json formatında ama bnm projede kulanmak icin bu jsonu modele cevirmem lazm FROMJSON  ile beraber
  factory Taskmodel.fromJson(Map<String, dynamic> json, String id) {
    return Taskmodel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      priority: json['priority'] ?? '',
      category: json['category'] ?? '',
      isdone: json['isdone'] ?? false,
    );
  }
  //şimdi mesela modelden giriln gorevlern frebaseye kaydetmke icin json formatına gerş cevirmemz lazm
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'priority': priority,
      'category': category,
      'isdone': isdone,
    };
  }

  Taskmodel copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? priority,
    String? category,
    bool? isdone,
  }) {
    return Taskmodel(
      //copywitle eski asıl nesneyi değiştirmiyoz eni nesne olstrdk bazı alanlaı eğiştk simdi o nesneyi yeni nsneyi returnal dondurmemz lzm
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isdone: isdone ?? this.isdone,
    );
  }
}
