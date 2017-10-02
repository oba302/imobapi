User.all.destroy

User.create!(name:  "Hugo Nakamura",
             email: "hugo@hugo.com",
             password:              "welcome",
             password_confirmation: "welcome",
             activated: true,
             activated_at: Time.zone.now)