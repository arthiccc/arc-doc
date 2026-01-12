class Document < ApplicationRecord
  belongs_to :category
  has_one_attached :file
  
  validates :title, presence: true
  validates :file, presence: true

  before_save :extract_content

  # Sorting logic
  scope :sorted_by, ->(sort_key, direction = "asc") {
    direction = %w[asc desc].include?(direction.to_s.downcase) ? direction : "asc"
    
    case sort_key.to_s
    when "name"
      order(title: direction)
    when "classification"
      joins(:category).order("categories.name #{direction}")
    when "uploaded"
      order(created_at: direction)
    when "modified"
      order(updated_at: direction)
    when "size"
      joins(:file_attachment).joins(:file_blob).order("active_storage_blobs.byte_size #{direction}")
    else
      order(created_at: :desc)
    end
  }

  # Enhanced Deep Search
  scope :search, ->(query) {
    return all if query.blank?
    
    results = joins(category: :department)
    
    # Natural Language Date Mapping
    months = {
      "jan" => 1, "january" => 1, "feb" => 2, "february" => 2,
      "mar" => 3, "march" => 3, "apr" => 4, "april" => 4,
      "may" => 5, "jun" => 6, "june" => 6, "jul" => 7, "july" => 7,
      "aug" => 8, "august" => 8, "sep" => 9, "september" => 9,
      "oct" => 10, "october" => 10, "nov" => 11, "november" => 11,
      "dec" => 12, "december" => 12
    }

    terms = query.downcase.split(/[\s,]+/)
    
    terms.each do |term|
      pattern = "%#{term}%"
      
      # Base Metadata & Content Search
      metadata_clause = "(LOWER(documents.title) LIKE ? OR 
                          LOWER(documents.description) LIKE ? OR 
                          LOWER(documents.content) LIKE ? OR
                          LOWER(categories.name) LIKE ? OR 
                          LOWER(departments.name) LIKE ?)"
      
      # Date matching logic for this term
      date_conditions = []
      date_values = []

      if term =~ /^\d{4}$/ # Year (e.g., 2026)
        date_conditions << "strftime('%Y', documents.created_at) = ?"
        date_values << term
      elsif (month_num = months[term]) # Month Name (e.g., Jan)
        date_conditions << "CAST(strftime('%m', documents.created_at) AS INTEGER) = ?"
        date_values << month_num
      elsif term =~ /^\d{1,2}$/ # Possible Day or Month Number
        date_conditions << "(CAST(strftime('%d', documents.created_at) AS INTEGER) = ? OR CAST(strftime('%m', documents.created_at) AS INTEGER) = ?)"
        date_values += [term.to_i, term.to_i]
      end

      if date_conditions.any?
        clause = "(#{metadata_clause} OR #{date_conditions.join(" OR ")})"
        results = results.where(clause, pattern, pattern, pattern, pattern, pattern, *date_values)
      else
        results = results.where(metadata_clause, pattern, pattern, pattern, pattern, pattern)
      end
    end

    results
  }

  private

  def extract_content
    return unless file.attached? && (new_record? || attachment_changes["file"])

    # Download to temp file for processing
    file.open do |temp|
      case file.content_type
      when "text/plain"
        self.content = temp.read.force_encoding("UTF-8").scrub
      when "application/pdf"
        # Using pdftotext (standard on Linux)
        self.content = `pdftotext #{temp.path} -`.force_encoding("UTF-8").scrub
      end
    end
  rescue => e
    Rails.logger.error "Text extraction failed: #{e.message}"
  end
end
