# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)      not null
#  isAdmin         :boolean          default(FALSE)
#  name            :string(255)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do

  factory :correct_user, class: User do
    name { "correct_name" }
    email { "correct@correct.com" }
    password { "correct_password" }
    password_confirmation { "correct_password" }

    factory :empty_name_user do
      name { "" }
    end

    factory :long_name_user do
      name { "x" * 17 }
    end

    factory :invalid_email_user do
      email { "wrong@wrong" }
    end

    factory :short_password_user do
      password { "short" }
      password_confirmation { "short" }
    end

    factory :not_match_password_user do
      password { "password" }
      password_confirmation { "confirmation" }
    end

  end
  
  factory :login_params, class: User do
    email { "correct@correct.com" }
    password { "correct_password" }
    password_confirmation { "correct_password" }
  end
  
  factory :update_name, class: User do
    name { "update" }
    
    factory :update_empty_name do
      name { "" }
    end
    
    factory :update_long_name do
      name { "a" * 17 }
    end

    factory :update_user do
      name { "update_name" }
      current_password { "correct_password" }
      password { "update_password" }
      password_confirmation { "update_password" }

      factory :update_empty_name_with_password do
        name { "" }
      end

      factory :update_with_wrong_password do
        current_password { "sample" }
      end

      factory :update_with_invalid_password do
        password { "testtest" }
        password_confirmation { "password" }
      end

      factory :update_with_short_password do
        password { "test" }
        password_confirmation { "test" }
      end
    end
  end

  
  # # 基本テスト側のファイルで生成する
  #   # DB保存しない状態で生成(アソシエーションは保存)
  #   sample = build(:sample_user)

  #   # DB保存しない状態で生成(アソシエーションも保存しない, IDには適当な値が入る)
  #   sample = build_stubbed(:sample_user)

  #   # DBに保存する生成
  #   sample = create(:sample_user)

  #   # 属性のハッシュを生成
  #   sample = attributes_for(:sample_user)
  #     # => {:name => "sample", :email => 'sample@sample.com'}

  # # 複数生成系。定義自体は『factory』ファイルで行う
  #   # 同じデータを複数生成
  #   samples = build_list(:sample_user, 3)

  #   # 連番を持ったデータを生成
  #   sequence :sample_sequence do |i|
  #     "サンプル #{i}"
  #   end
  #   factory :sample_user, class User do
  #     name { generate :sample_sequence }
  #     email { "sample@sample.com" }
  #   end
  #   build(:sample_user)
  #   build(:sample_user)
  #     # => #<User id: nil, name: "サンプル 1", email: ...
  #     # => #<User id: nil, name: "サンプル 2", email: ...

  #   # ブロック『{}』で囲んだフィールドは、生成時にその値を評価する。例: 現在時刻等
  #   factory :sample_user, class: User do
  #     name: 'Sample'
  #     email: { "{name}".downcase } 
  #   end


  #   # アソシエーション定義
  #   # Userモデルの参照(author)を持つBookモデルの場合
  #   factory :sample_user, class: User do
  #     name : 'sample',
  #   end
  #   factory :sample_book, class: Book do
  #     title 'sample_title'
  #     association :author,
  #       factory: :sample_user, # アソシエーション先のファクトリを明示
  #       strategy: :build, # アソシエーションの生成方法を指定(任意)
  #       isAdmin: true # アソシエーション先の属性をオーバーライドできる(任意)
  #   end
  #   # test側のファイル
  #   sample = build_stubbed(:sample_book)


  #   # エイリアスを定義 # ファクトリに別名をつけることができる。
  #   factory :sample_user, class: User, aliases: [:author] do
  #     name : 'sample',
  #   end
  #   factory :sample_book, class: Book do
  #     title 'sample_title'
  #     # 下と同義
  #     # association :author, factory: :sample_book
  #     author
  #   end

  #   # 予約語を回避
  #   factory :user do
  #     add_attribute(:do){ 'do value' }
  #   end

  #   # 属性以外のパラメータを持たせる(transient)
  #   factory :user do
  #     transient do
  #       name_is ''
  #       be_admin false
  #     end
  #     name { "#{name_is}" }
  #     admin { "#{be_admin}" }
  #   end
  #   sample_user = build(:user, name_is: 'sample', be_admin: true)

    
  #   # ネスト定義することで継承できる
  #   factory :user do
  #     name '-'
  #     admin false
      
  #     factory :sample_user do
  #       nami: 'sample'
  #     end
  #   end

  #   # ネストせずとも継承できる
  #   factory :sample_user, parent: :user do
  #     name: 'sample'
  #   end

    
  #   # ファクトリを継承せずに内容を変更
  #   FactoryBot.define do
  #     factory :sample_user do
  #       name 'sample'
  #       admin true
  #     end
  #   end
  #   FactoryBot.modify do
  #     factory :sample_user do
  #       name 'sample-2'
  #     end
  #   end
end
