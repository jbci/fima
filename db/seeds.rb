# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create({email: 'lab@ciudadanointeligente.org', password: 'xxxxxxxx', password_confirmation: 'xxxxxxxx'})
# AreaLevel.create([{name: 'País'}, {name: 'Región'}, {name: 'Provincia'}, {name: 'Comuna'}])

level_0 = AreaLevel.create(name: 'País')
level_1 = AreaLevel.create(name: 'Región')
level_2 = AreaLevel.create(name: 'Provincia')
level_3 = AreaLevel.create(name: 'Comuna')
chile = Area.first_or_create(name: 'Chile', area_level: level_0)
region_m = chile.children.create(name: 'Región Metropolitana', area_level: level_1)
provincia_s = region_m.children.create(name: 'Provincia de Santiago', area_level: level_2)
providencia = provincia_s.children.create(name: 'Providencia', area_level: level_3)

Rating.create({title: 'Índice FIMA', description: 'Descripción del índice FIMA'})
