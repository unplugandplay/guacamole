# -*- encoding : utf-8 -*-
require 'guacamole'
require 'acceptance/spec_helper'

require 'fabricators/book'
require 'fabricators/author'

class AuthorsCollection
  include Guacamole::Collection

  map do
    referenced_by :books
  end
end

class BooksCollection
  include Guacamole::Collection

  map do
    references :author
  end
end

describe 'Associations' do

  let(:author) { Fabricate(:author_with_three_books) }

  it 'should load referenced models from the database' do
    the_author        = AuthorsCollection.by_key author.key
    books_from_author = BooksCollection.by_example(author_id: author.key).to_a

    expect(books_from_author).to eq the_author.books.to_a
  end

  it 'should load the referenced model from the database' do
    the_author           = AuthorsCollection.by_key author.key
    a_book_by_the_author = BooksCollection.by_example(author_id: author.key).to_a.first

    expect(a_book_by_the_author.author).to eq the_author
  end
end
