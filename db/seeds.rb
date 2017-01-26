# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.first_or_create({email: 'lab@ciudadanointeligente.org', password: 'xxxxxxxx', password_confirmation: 'xxxxxxxx'})
AreaLevel.first_or_create([{name: 'País'}, {name: 'Región'}, {name: 'Provincia'}, {name: 'Comuna'}])

Rating.first_or_create({title: 'Índice FIMA', description: 'Descripción del índice FIMA'})
