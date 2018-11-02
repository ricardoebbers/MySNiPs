class CardsController < ApplicationController
  def make_report
    userid = params[:userid] if params.key? :userid
    return if userid.nil?

    @cards_hash = {}
    read_file Rails.root.join("data", "genomas", userid.to_s + ".gnm")
  end

  def read_file(path)
    File.open(path, "r").each do |line|
      snp = build_snp line.split("\t")
      next if snp.nil?

      # TO-DO
    end
  end

  def build_snp(data)
    return nil if data.count != 4

    snp = {}
    snp[:id] = data[0]
    snp[:chromosome] = data [1]
    snp[:allele1] = data[2][0]
    snp[:allele2] = data[2][1]
    snp
  end

  def insert_db
    # TO-DO
  end
end
