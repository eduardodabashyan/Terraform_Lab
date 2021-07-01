output "movie_db" {
    value = aws_db_instance.movie-db.address
}

output "book_db" {
    value = aws_db_instance.book-db.address
}