class Museum
  attr_reader :name, :exhibits, :patrons, :revenue, :patrons_of_exhibits

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
    @patrons_of_exhibits = {}
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all{ |exhibit| patron.interests.include?(exhibit.name) }.reverse
    @exhibits.find_all{ |exhibit| patron.interests.include? exhibit.name }# ** THIS IS HOW IAN & MEG DID IT - BASED ON THE ORDER THE EXHIBITS LISTED THEM IN *NOT* THE ORDER THE OF PATRONS INTERESTS
  end

  def admit(patron)
    @patrons << patron
    recommend_exhibits(patron)
    .sort_by{|exhibit| exhibit.cost}
    .reverse
    .each do |exhibit|
      if exhibit.cost <= patron.spending_money
        patron.spending_money -= exhibit.cost
        @revenue += exhibit.cost
        @patrons_of_exhibits[exhibit] = [] unless @patrons_of_exhibits.key? exhibit
        @patrons_of_exhibits[exhibit] << patron
      end
    end
  end

  # def patrons_by_exhibit_interest
  #   exhibit_patrons = Hash.new(0)
  #   @exhibits.map do |exhibit|
  #       exhibit_patrons[exhibit] = @patrons
  #     end
  #     # exhibit_patrons
  #   end

    def patrons_by_exhibit_interest
      exhibit_interests = Hash.new
      @exhibits.each do |exhibit|
        exhibit_interests[exhibit] = []
      end
      @patrons.each do |patron|
        recommend_exhibits(patron).each do |exhibit|
          exhibit_interests[exhibit] << patron
        end
      end
      exhibit_interests
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
