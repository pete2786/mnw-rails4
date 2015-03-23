module Season
  def season
    case day_hash
      when 101..320 then 'winter'
      when 321..620 then 'spring'
      when 621..922 then 'summer'
      when 923..1221 then 'fall'
      else 'winter'
    end
  end

  def day_hash
    @day_hash ||= Time.now.month * 100 + Time.now.mday
  end

  def season?(season)
    season.eql?(season)
  end
end
