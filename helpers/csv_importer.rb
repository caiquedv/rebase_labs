require 'csv'
require_relative '../services/database'

class CSVImporter
  def self.import(conn)
    rows = CSV.read('./data/data.csv', col_sep: ';')

    columns = normalize_column_names(rows.shift)

    rows_data = build_rows_data(rows, columns)

    query = build_insert_query(rows_data, columns)

    conn.exec(query)
    conn.exec('SELECT * FROM tests;')
  end

  def self.normalize_column_names(columns)
    columns.map do |column|
      column.gsub(%r{[/\s]}, '_')
            .gsub(/[éèê]/, 'e')
            .gsub('ç', 'c')
    end
  end

  def self.build_rows_data(rows, columns)
    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell.gsub("'", "''")
      end
    end
  end

  def self.build_insert_query(rows, columns)
    query = "INSERT INTO tests (#{columns.join(', ')}) VALUES "

    rows.each_with_index do |row, idx|
      query << "('#{row.values.join("', '")}')"
      query << ', ' if idx != rows.length - 1
    end

    "#{query};"
  end
end
