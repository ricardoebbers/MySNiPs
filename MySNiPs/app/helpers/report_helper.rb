module ReportHelper
  def text_for_total_or_found total, found
    if total == found
      "Total de " + total.to_s + " cards"
    else
      found.to_s + "/" + total.to_s + " cards encontrados"
    end
  end
end
