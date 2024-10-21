# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Quiz.create([
    { content: '日本のIT人材が2030年には最大どれくらい不足すると言われているでしょうか？', image: 'quiz01.png', supplement: '経済産業省 2019年3月 － IT 人材需給に関する調査'},
    { content: '既存業界のビジネスと、先進的なテクノロジーを結びつけて生まれた、新しいビジネスのことをなんと言うでしょう？', image: 'quiz02.png', supplement: '' },
    { content: 'IoTとは何の略でしょう？', image: 'quiz03.png', supplement: '' },
    { content: 'サイバー空間とフィジカル空間を高度に融合させたシステムにより、経済発展と社会的課題の解決を両立する、人間中心の社会のことをなんと言うでしょう？', image: 'quiz04.png', supplement: 'Society5.0 - 科学技術政策 - 内閣府' },
    { content: 'イギリスのコンピューター科学者であるギャビン・ウッド氏が提唱した、ブロックチェーン技術を活用した「次世代分散型インターネット」のことをなんと言うでしょう？', image: 'quiz05.png', supplement: '' },
    { content: '先進テクノロジー活用企業と出遅れた企業の収益性の差はどれくらいあると言われているでしょうか？', image: 'quiz06.png', supplement: 'Accenture Technology Vision 2021' },
])