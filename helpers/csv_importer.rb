require 'csv'
require_relative '../services/database'

class CSVImporter
  def self.import
    rows = CSV.read("./data/data.csv", col_sep: ';')

    columns = process_columns(rows.shift)

    create_table(columns)

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end

  end

  def self.create_table(columns)
    conn = DatabaseConfig.connect
    conn.exec(
      "CREATE TABLE IF NOT EXISTS exams (
        id SERIAL PRIMARY KEY,
        #{columns.map { |col| col.include?('data') ? "#{col} DATE" : "#{col} VARCHAR" }.join(', ') }
      );"
    ) 
    conn.close
  end

  def self.process_columns(columns)
    processed_columns = columns.map do |column|
      column.downcase.gsub(/[^a-z0-9\s]/i, '').gsub(/\s+/, '_')
    end
    processed_columns
  end  
end