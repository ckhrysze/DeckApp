class Deck < ActiveRecord::Base
  has_many :runs
  has_many :cards, :through => :runs

  def mana_curve_chart
    google_chart_base_url = "http://chart.apis.google.com/chart?"
    parameters = []
    parameters << "chs=200x200"
    parameters << "chco=76A4FB"
    parameters << "cht=bvs"
    parameters << "chtt=Mana+Curve"
    parameters << "chxt=x,y"
    google_chart_base_url + parameters.concat(calculated_chart_params).join("&")
  end

  def calculated_chart_params
    cmcs = cmc_values
    x_range = [0, 1, cmcs.length]
    y_range = [1, 0, cmcs.sort.last.to_i+1]
    scale = [0, cmcs.sort.last.to_i+1]
    ["chd=t:#{cmcs.join(',')}",
     "chxr=#{x_range.join(',')}|#{y_range.join(',')}",
     "chds=#{scale.join(',')}"]
  end

  def mana_curve_alt
    "cost_curve:#{cmc_values}"
  end

  def cmc_values
    return [] if maindeck.nonlands.length == 0

    dataset = {}
    maindeck.nonlands.each do |r|
      if dataset.has_key?(r.cmc)
        dataset[r.cmc] += r.count 
      else
        dataset[r.cmc] = r.count
      end
    end
    high = dataset.keys.sort.last
    (1..high).each do |i|
      if !dataset.has_key?(i)
        dataset[i] = 0
      end
    end
    dataset.sort.map { |key,value|
      value
    }
  end

  def maindeck
    runs.maindeck(true)
  end
  def sideboard
    runs.sideboard(true)
  end
  def considering
    runs.considering(true)
  end
end
