# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(username: 'admin', email: 'nadtochiy1915@gmail.com', password: 'Welcum to issue-timer')
m0ksem = User.create(username: 'm0ksem', email: 'm0ksem@gmail.com', password: 'Welcum to m0ksem issue-timer')

team = Team.create(name: 'BIBIP')
project = Project.create(name: 'BIBIP', team_id: team.id)
service = Service.create(name: 'Github', hostname: 'github.com')


task = Task.create(name: 'Create database', url: 'https://github.com/m0ksem/issue-timer/issues/5', service_id: service.id, project_id: project.id )
timer = Timer.create(description: 'Cool timer', task_id: task.id)
timer_period = TimePeriod.create(start: Time.now - 1.hour, end: Time.now, timer_id: timer.id)

admin.tasks << task
m0ksem.tasks << task