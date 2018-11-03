# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# x = Gene.create({:title=>"I3002455", :revid=>1195440, :orientation=>false, :stabilized=>false, :iid=>"3002455", :rsid=>"1800386", :position=>6127833, :chromosome=>"12"})
role = Role.new({:role_name => "admin"})
role.save if role.valid?
role = Role.create({:role_name => "laboratorio"})
role.save if role.valid?
role = Role.create({:role_name => "usuario_final"})
if role.valid?
    role.save
else
    role = Role.find_by(:role_name => "usuario_final")
end
user = role.users.create({:identifier=>"0010000001", :password_digest=>"$2a$10$tUJcvKA.QbKuBSKfno2CtuTjmgLo89/6zdWO3mFMB4LaHBG0Qmz3m"})
if user.valid?
    user.save
else
    user = User.find_by(:identifier => "0010000001")
end
genoma = user.genomas.create({:status => 1})

