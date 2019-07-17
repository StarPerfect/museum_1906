class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all{ |exhibit| patron.interests.include?(exhibit.name) }.reverse
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    exhibit_patrons = Hash.new(0)
    @exhibits.map do |exhibit|
        exhibit_patrons[exhibit] = @patrons
      end
      # exhibit_patrons
    end
  end
#
#     if patron.interests.include?(exhibit)
#       patron
#     end
#   end )

      # exhibit_patrons[exhibit] = 5
      # @patrons.each do |patron|
      #   if patron.interests.include?(exhibit)
      # #    @patrons.each do |patron|
      #    if patron.interests.include?(exhibit)
      #exhibit_patrons
