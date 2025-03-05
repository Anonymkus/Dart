import 'dart:io';

class Book {
  String title;
  Author author;
  String isbn;
  bool isTaken = false;

  Book({required this.title, required this.author, required this.isbn});
}

class Member {
  String fullName;
  String email;
  String phoneNumber;

  Member({required this.fullName, required this.email, required this.phoneNumber});
}

class Author {
  String fullName;
  String email;
  String phoneNumber;
  String status;

  Author({required this.fullName, required this.email, required this.phoneNumber, required this.status});
}

class Loan {
  Member member;
  Book book;
  DateTime loanDate;
  DateTime? returnDate;

  Loan({required this.member, required this.book, required this.loanDate, this.returnDate});
}

class Library {
  List<Book> books = [];
  List<Author> authors = [];
  List<Member> members = [];
  List<Loan> loans = [];

  void addBook(Book book) {
    books.add(book);
    print("Книга ${book.title} добавлена в библиотеку.");
  }

  void addMember(Member member) {
    members.add(member);
    print("Член библиотеки ${member.fullName} добавлен.");
  }

  void loanBook(Member member, Book book) {
    if (book.isTaken) {
      print("Ошибка: Книга ${book.title} уже выдана.");
      return;
    }
    book.isTaken = true;
    loans.add(Loan(member: member, book: book, loanDate: DateTime.now()));
    print("Книга ${book.title} выдана ${member.fullName}.");
  }

  void returnBook(Book book) {
    for (var loan in loans) {
      if (loan.book == book && loan.returnDate == null) {
        loan.returnDate = DateTime.now();
        book.isTaken = false;
        print("Книга ${book.title} возвращена.");
        return;
      }
    }
    print("Ошибка: Книга ${book.title} не числится в займах.");
  }

  void listBooks() {
    for (var book in books) {
      if (book.isTaken){
        print("(${books.indexOf(book)}) ${book.title} - выдана");
      }
      else{
        print("(${books.indexOf(book)}) ${book.title} - доступна");
      }
    }
  }

  void listMembers() {
    for (var member in members) {
      print("(${members.indexOf(member)}) Член библиотеки: ${member.fullName}, эл. почта: ${member.email}, телефон: ${member.phoneNumber}");
    }
  }

  void searchBook(String line) {
    var foundBooks = [];
    for (var book in books){
      var findBook = book.title.toLowerCase();
      var findAuthor = book.author.fullName.toLowerCase();
      if (findBook.contains(line) || findAuthor.contains(line)){
        foundBooks.add(book);
      }
    }
    if (foundBooks.isEmpty) {
      print("Книг не найдено.");
    } else {
      print("Найденные книги:");
      for (var book in foundBooks) {
        print("${book.title} - Автор: ${book.author.fullName}");
      }
    }
  }
}

void main() {
  var work = true;
  var library = Library();

  var author1 = Author(fullName: "Автор1", email: "author1@email.com", phoneNumber: "123456789", status: "Активный");
  var book1 = Book(title: "Книга1", author: author1, isbn: "123-456-789");

  var member1 = Member(fullName: "Член1", email: "member1@email.com", phoneNumber: "987654321");

  library.authors.add(author1);
  library.addBook(book1);
  library.addMember(member1);
  library.loanBook(member1, book1);

  while (work){
    print("");
    print("Выберите действие: ");
    print("1 - добавить книгу");
    print("2 - добавить члена");
    print("3 - выдача книги");
    print("4 - возврат книги");
    print("5 - список книг");
    print("6 - список членов");
    print("7 - поиск книг");
    print("0 - выйти");
    
    var choice = stdin.readLineSync();

    switch (choice){
      case "1":
        print("Введите название книги");
        var title = stdin.readLineSync().toString().trim();
        for (var author in library.authors){
          print("${library.authors.indexOf(author)} - ${author.fullName}");
        }
        print("Введите индекс автора");
        var author = library.authors.elementAt(int.tryParse(stdin.readLineSync().toString()) ?? 0);
        print("Введите мскн");
        var isbn = stdin.readLineSync().toString().trim();

        library.addBook(Book(title:title, author:author, isbn:isbn));
        break;
      case "2":
        print("Введите имя нового члена");
        var fullName = stdin.readLineSync().toString().trim();
        print("Введите почту нового члена");
        var email = stdin.readLineSync().toString().trim();
        print("Введите телефон нового члена");
        var phoneNumber = stdin.readLineSync().toString().trim();
        library.addMember(Member(fullName: fullName, email: email, phoneNumber: phoneNumber));
        break;
      case "3":
        library.listMembers();
        print("Введите индекс члена");
        var member = library.members.elementAt(int.tryParse(stdin.readLineSync().toString()) ?? 0);
        library.listBooks();
        print("Введите индекс книги");
        var book = library.books.elementAt(int.tryParse(stdin.readLineSync().toString()) ?? 0);
        library.loanBook(member, book);
        break;
      case "4":
        library.listBooks();
        print("Введите индекс книги");
        var book = library.books.elementAt(int.tryParse(stdin.readLineSync().toString()) ?? 0);
        library.returnBook(book);
        break;
      case "5":
        library.listBooks();
        break;
      case "6":
        library.listMembers();
        break;
      case "7":
        print("Вводите: ");
        var line = stdin.readLineSync().toString().toLowerCase();
        library.searchBook(line);
        break;
      case "0":
        print("Выход...");
        work = false;
        break;
    }
  }
}