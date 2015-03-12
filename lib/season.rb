module Season
  def season
    case day_hash
      when 101..401 then 'winter'
      when 402..630 then 'spring'
      when 701..930 then 'summer'
      when 1001..1231 then 'fall'
    end
  end

  def day_hash
    @day_hash ||= Time.now.month * 100 + Time.now.mday
  end

  def season?(season)
    season.eql?(season)
  end
end
