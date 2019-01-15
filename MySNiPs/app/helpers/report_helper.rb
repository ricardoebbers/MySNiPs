module ReportHelper
  def text_for_total_or_found total, found
    if total == found
      "Total de " + total.to_s + " cards"
    else
      found.to_s + "/" + total.to_s + " cards encontrados"
    end
  end

  def graph_by_repute_or_magnitude
    return graph_by_magnitude if @repute1 || @repute2

    # else
    graph_by_repute
  end

  def graph_by_repute
    pie_chart @found_cards.group("genotypes.repute").count.map {|rep, count|
      [%w[Neutral Good Bad][rep], count]
    }, width: "200px", legend: {enabled: false}
  end

  def graph_by_magnitude
    counts = {}
    bar_chart @found_cards.group("genotypes.magnitude").count.map {|magn, count|
      total = counts.fetch(magn.floor, 0)
      counts[magn.floor] = total + count
      [magn.floor.to_s + " a " + (magn.floor + 1).to_s, total + count]
    }, width: "200px", library: {}
  end
end
