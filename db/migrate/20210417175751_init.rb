class Init < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps
    end

    create_table :tasks do |t|
      t.string :name
      t.string :url
      t.integer :service_id

      t.timestamps
    end

    create_table :services do |t|
      t.string :name
      t.string :hostname

      t.timestamps
    end

    create_table :timers do |t|
      t.string :description
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end

    create_table :periods do |t|
      t.timestamp :start
      t.timestamp :end

      t.timestamps
    end

    create_join_table :users, :tasks do |t|
      t.index :user_id
      t.index :task_id
    end

    create_join_table :timers, :periods do |t|
      t.index :timer_id
      t.index :period_id
    end
  end
end
