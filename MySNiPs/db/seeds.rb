# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# x = Gene.create({:title=>"I3002455", :revid=>1195440, :orientation=>false, :stabilized=>false, :iid=>"3002455", :rsid=>"1800386", :position=>6127833, :chromosome=>"12"})
Role.create(role_name: "admin")
role = Role.find_by(role_name: "admin")
User.create(identifier: "admin",
            password: "987987",
            password_digest: "$2a$10$KmZcwIwf6nHRR2iPv78lZOl1e5Q.oJ0NkmmWRqg7F5GS2dKi6puTy",
            role_id: role.id)


Role.create(role_name: "laboratorio")
role = Role.find_by(role_name: "laboratorio")
User.create(identifier: "001",
            password: "654654",
            password_digest: "$2a$10$LGdxSgGp2el3DMDBZPb5E.XzuD4D783wJUn4I5uDrQmxEASquHCjS",
            role_id: role.id)

Role.create(role_name: "usuario_final")
role = Role.find_by(role_name: "usuario_final")
User.create(identifier: "0010000001",
            password: "123",
            password_digest: "$2a$10$tUJcvKA.QbKuBSKfno2CtuTjmgLo89/6zdWO3mFMB4LaHBG0Qmz3m",
            role_id: role.id)
user = User.find_by(identifier: "0010000001")
Genoma.create(status: 1, user_id: user.id)
