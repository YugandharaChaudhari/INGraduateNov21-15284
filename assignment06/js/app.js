function Book(bookid, bookname, authorname){
    this.bookid=bookid;
    this.bookname = bookname;
    this.authorname = authorname;
    this.displayDetails = function(){
        return this.bookid + " " + this.bookname +" " +this.authorname;
    };
}
const BookObject = new Book("1", "My Jounrny","hbg");
const result = document.getElementById("result");
result.innerHTML = BookObject.displayDetails();