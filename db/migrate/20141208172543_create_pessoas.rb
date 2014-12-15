class CreatePessoas < ActiveRecord::Migration
  def change
    create_table :pessoas do |t|
      t.string :login
      t.string :senha
      t.string :nome
      t.string :cidade
      t.string :estado
      t.string :email
      t.text :descricao

      t.timestamps
    end
  end
end
