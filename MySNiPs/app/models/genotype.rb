class Genotype < ApplicationRecord
  belongs_to :gene
  has_many :cards
  has_many :users, :through => :cards
  validates :allele1, length: {is: 1}
  validates :allele2, length: {is: 1}
  validates :allele1, :allele2, presence: true
  validates :title, presence: true, uniqueness: true

  def repute_gradient
    case repute
    when 1 then ["rgb(235,255,235)", "rgb(180,255,180)", "rgb(140,255,140)", "rgb(80,225,80)", "rgb(0,200,0)"]
    when 2 then ["rgb(255,235,235)", "rgb(255,180,180)", "rgb(255,140,140)", "rgb(225,80,80)", "rgb(200,0,0)"]
    end
  end

  def color
    case magnitude
    when 0 then repute_gradient[0]
    when 0.1..1.5 then repute_gradient[1]
    when 1.6..3.5 then repute_gradient[2]
    when 3.6..5.9 then repute_gradient[3]
    else repute_gradient[4]
    end
  end

  def rep_text
    case repute
    when 1 then "+"
    when 2 then "-"
    when 0 then "~"
    end
  end

  def page_text
    result = page_content
    link_format = /(?<=\[\[)(.*?)(?=\]\])/
    links = result.match(link_format) { |m| m.captures }
    unless links.nil?
      links.each do |l|
        result.gsub!(l, make_link(l))
      end
      result.gsub! "[[", "&nbsp"
      result.gsub! "]]", "&nbsp"
    end
    result += "&nbsp" + read_more
    result.strip.delete("\t\r\n").html_safe
  end

  def make_link(text, page=nil)
    page = text.gsub " ", "_" if page.nil?
    ' <a href="' + "http://snpedia.com/index.php/#{page}" + '" target="_blank"' + "> #{' ' + text + ' '} </a> "
  end

  def read_more
    if page_content.empty?
      make_link("Read about the Gene", gene.title)
    else
      make_link(" ...read more", title)
    end
  end
end
