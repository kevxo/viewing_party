class CastMember
  attr_reader :name,
              :character
  def initialize(cast_data)
    @name = cast_data[:name]
    @character = cast_data[:character]
  end
end
