import 'dart:io';

void main(List<String> arguments) {
  String bookTitle = "";
  String bookAuthor = "";
  int? bookYear = 0;
  DateTime today = DateTime.now();
  File myFile = File('books/${today.day}-${today.month}-${today.year}.txt');
  myFile.createSync(recursive: true);
  print("Введите число книг, которые вы хотите записать");
  int cycle = int.tryParse(stdin.readLineSync().toString()) ?? 0;
  int step = 0;

  while (step != cycle)
  {
    print(" ");
    step+=1;
    print("Введите название книги");
    bookTitle = stdin.readLineSync().toString();
    print("Введите автора книги");
    bookAuthor = stdin.readLineSync().toString();
    print("Введите год издания книги");
    bookYear = int.tryParse(stdin.readLineSync().toString());

    myFile.writeAsStringSync('$bookTitle - $bookAuthor. $bookYear.\n', mode: FileMode.append);
  }
}
