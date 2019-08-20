# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminSet.find_or_create_default_admin_set_id
default = Hyrax::CollectionType.find_or_create_default_collection_type
admin_set = Hyrax::CollectionType.find_or_create_admin_set_type
