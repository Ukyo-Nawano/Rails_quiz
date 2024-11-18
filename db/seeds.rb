# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create([
    { name: '山田太郎', email: 'quiz01.png', image: 'quiz01.png',  password:"password" },
    { name: '佐藤花子', email: 'quiz01.png', image: 'quiz01.png',  password:"password" },
    { name: '鈴木祐輔', email: 'quiz01.png', image: 'quiz01.png',  password:"password" },
    { name: '高橋めぐみ', email: 'quiz01.png', image: 'quiz01.png',  password:"password" },
    { name: '横田洋二', email: 'quiz01.png', image: 'quiz01.png',  password:"password" },
])
Quiz.create([
    { title: 'ITクイズ', image: 'quiz01.png', user_id:1 },
    { title: 'ITクイズ', image: 'quiz01.png', user_id:2 },
    { title: 'ITクイズ', image: 'quiz01.png', user_id:3 },
    { title: 'ITクイズ', image: 'quiz01.png', user_id:3 },
    { title: 'ITクイズ', image: 'quiz01.png', user_id:4} ,
])
Question.create([
    { content: '日本のIT人材が2030年には最大どれくらい不足すると言われているでしょうか？', image: 'quiz01.png', supplement: '経済産業省 2019年3月 － IT 人材需給に関する調査', quiz_id:1, point_id:3},
    { content: '既存業界のビジネスと、先進的なテクノロジーを結びつけて生まれた、新しいビジネスのことをなんと言うでしょう？', image: 'quiz02.png', supplement: '' , quiz_id:3, point_id:4},
    { content: 'IoTとは何の略でしょう？', image: 'quiz03.png', supplement: '' , quiz_id:2, point_id:5},
    { content: 'サイバー空間とフィジカル空間を高度に融合させたシステムにより、経済発展と社会的課題の解決を両立する、人間中心の社会のことをなんと言うでしょう？', image: 'quiz04.png', supplement: 'Society5.0 - 科学技術政策 - 内閣府' , quiz_id:1, point_id:4},
    { content: 'イギリスのコンピューター科学者であるギャビン・ウッド氏が提唱した、ブロックチェーン技術を活用した「次世代分散型インターネット」のことをなんと言うでしょう？', image: 'quiz05.png', supplement: '' , quiz_id:5, point_id:6},
    { content: '先進テクノロジー活用企業と出遅れた企業の収益性の差はどれくらいあると言われているでしょうか？', image: 'quiz06.png', supplement: 'Accenture Technology Vision 2021' , quiz_id:4, point_id:2},
])
Choice.create([
    { question_id: 1, name: '約28万人', is_valid: false },
    { question_id: 1, name: '約79万人', is_valid: true },
    { question_id: 1, name: '約183万人', is_valid: false },
    { question_id: 2, name: 'INTECH', is_valid: false },
    { question_id: 2, name: 'BIZZTECH', is_valid: false },
    { question_id: 2, name: 'X-TECH', is_valid: true },
    { question_id: 3, name: 'Internet of Things', is_valid: true },
    { question_id: 3, name: 'Integrate into Technology', is_valid: false },
    { question_id: 3, name: 'Information on Tool', is_valid: false },
    { question_id: 4, name: 'Society 5.0', is_valid: true },
    { question_id: 4, name: 'CyPhy', is_valid: false },
    { question_id: 4, name: 'SDGs', is_valid: false },
    { question_id: 5, name: 'Web3.0', is_valid: true },
    { question_id: 5, name: 'NFT', is_valid: false },
    { question_id: 5, name: 'メタバース', is_valid: false },
    { question_id: 6, name: '約2倍', is_valid: false },
    { question_id: 6, name: '約5倍', is_valid: true },
    { question_id: 6, name: '約11倍', is_valid: false },
])
UserQuestion.create([
    { user_id: 3, question_id: 1, result: true, is_first: false },
    { user_id: 3, question_id: 2, result: true, is_first: false },
    { user_id: 3, question_id: 3, result: true, is_first: false },
    { user_id: 3, question_id: 4, result: true, is_first: false },
    { user_id: 3, question_id: 5, result: true, is_first: false },
    { user_id: 3, question_id: 6, result: true, is_first: false },
])
Point.create([
    { point: 5 },
    { point: 10 },
    { point: 15},
    { point: 20 },
    { point: 25 },
    { point: 30 },
    { point: 35 },
    { point: 40 },
    { point: 45 },
    { point: 50 },
    { point: 55 },
    { point: 60 },
    { point: 65 },
    { point: 70 },
    { point: 75 },
    { point: 80 },
    { point: 85 },
    { point: 90 },
    { point: 95 },
    { point: 100 },
])
Favorite.create([
    { user_id: 3, quiz_id: 1, favorite: true },
    { user_id: 3, quiz_id: 2, favorite: true },
    { user_id: 3, quiz_id: 4, favorite: true },
    { user_id: 1, quiz_id: 2, favorite: true },
    { user_id: 2, quiz_id: 3, favorite: true },
    { user_id: 4, quiz_id: 1, favorite: true },
])
TagQuiz.create([
    { quiz_id: 1, tag_id: 1 },
    { quiz_id: 1, tag_id: 2 },
    { quiz_id: 2, tag_id: 3 },
    { quiz_id: 3, tag_id: 2 },
    { quiz_id: 3, tag_id: 4 },
    { quiz_id: 4, tag_id: 1 },
])
Tag.create([
    { tag: "IT" },
    { tag: "食品" },
    { tag: "家電" },
    { tag: "料理" },
    { tag: "学校" },
    { tag: "TV" },
])