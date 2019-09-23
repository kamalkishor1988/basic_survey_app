# Destroy Records
User.destroy_all

User.create(email: 'admin@example.com', password: 'admin@123', password_confirmation: 'admin@123', is_admin: true)
User.create(email: 'kkishor313@gmail.com', password: 'kamal@123', password_confirmation: 'kamal@123')