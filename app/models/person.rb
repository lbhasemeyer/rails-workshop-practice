class Person < ActiveRecord::Base

  validates :last_name, presence: true, uniqueness: {case_sensitive: false}

  validate :first_name_or_title


  def full_name
    "#{self.title} #{self.first_name} #{self.last_name}"
  end

  def first_name_or_title
    if(title.nil? || title.empty?) && (first_name.nil? || first_name.empty?)
      errors.add(:title, ' or First Name must be entered.')
    end
  end

end
