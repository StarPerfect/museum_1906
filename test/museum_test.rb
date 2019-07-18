require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/museum'
require './lib/exhibit'
require './lib/patron'

class MuseumTest < Minitest::Test
  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new("Bob", 10)
    # @bob.add_interest("Dead Sea Scrolls")
    # @bob.add_interest(@dead_sea_scrolls.name)
    # @bob.add_interest("Gems and Minerals")
    # @bob.add_interest(@gems_and_minerals.name)
    @sally = Patron.new("Sally", 20)
  #  @sally.add_interest("IMAX")
#    @sally.add_interest(@imax.name)
    @morgan = Patron.new("Morgan", 15)
  end

  def test_museum_exists
    assert_instance_of Museum, @dmns
  end

  def test_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
    assert_equal 0, @dmns.revenue
  end

  def test_add_exhibit
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_recommends_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @sally.add_interest("IMAX")
    @bob.add_interest(@gems_and_minerals.name)
    @bob.add_interest(@dead_sea_scrolls.name)

  #  assert_equal [@dead_sea_scrolls, @gems_and_minerals], @dmns.recommend_exhibits(@bob)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@bob) #***THIS IS HOW MEG & IAN DID
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_museum_patrons
    assert_equal [], @dmns.patrons

    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @dmns.admit(@bob)
    @dmns.admit(@sally)
    @bob.add_interest(@dead_sea_scrolls.name)
    @bob.add_interest(@gems_and_minerals.name)
    @sally.add_interest(@dead_sea_scrolls.name)

    expected = {
      @gems_and_minerals => [@bob],
      @dead_sea_scrolls => [@bob, @sally],
      @imax => []
    }

    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end

  def test_admitting_user_reduces_spending_money
    @dmns.add_exhibit(@dead_sea_scrolls)
    @bob.add_interest(@dead_sea_scrolls.name)
    @dmns.add_exhibit(@imax)
    @sally.add_interest(@imax.name)
    @sally.add_interest(@dead_sea_scrolls.name)
    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal 0, @bob.spending_money
    assert_equal 5, @sally.spending_money
  end

  def test_patrons_of_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@imax)
    @dmns.add_exhibit(@dead_sea_scrolls)

    @morgan.add_interest(@gems_and_minerals.name)
    @morgan.add_interest(@dead_sea_scrolls.name)
    @bob.add_interest(@dead_sea_scrolls.name)
    @bob.add_interest(@imax.name)
    #@sally.add_interest(@gems_and_minerals.name)
    @sally.add_interest(@imax.name)

    @dmns.admit(@bob)
    @dmns.admit(@morgan)
    @dmns.admit(@sally)


    expected = {
      @dead_sea_scrolls => [@bob, @morgan],
      @imax => [@sally],
      @gems_and_minerals => [@morgan]
    }
    assert_equal expected, @dmns.patrons_of_exhibits
  end
end
