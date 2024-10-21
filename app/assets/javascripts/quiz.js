// "use strict";

// {
//     // 全てのクイズの配列//
//     const quizSet = [{
//         quizNumber:0,
//         q:"日本のIT人材が2030年には最大どれくらい不足すると言われているでしょうか？",
//         image:"../img/img-quiz01.png",
//         a: ["約79万人", "約28万人", "約183万人"],
//         n:'経済産業省 2019年3月 － IT 人材需給に関する調査',
//         t:"約79万人"
//     },
//     {
//         quizNumber:1,
//         q:"既存業界のビジネスと、先進的なテクノロジーを結びつけて生まれた、新しいビジネスのことをなんと言うでしょう？",
//         image:"../img/img-quiz02.png",
//         a: ["X-TECH","INTECH", "BIZZTECH"],
//         t:"X-TECH",
//     },
//     {
//         quizNumber:2,
//         q:"lotとは何の略でしょう？",
//         image:"../img/img-quiz03.png",
//         a:["Internet of Things", "Integrate into Technology","Information om Tool"],
//         t:"Internet of Things",
//     },
//     {
//         quizNumber:3,
//         q:"日本が目指すサイバー空間とフィジカル空間を高度に融合させたシステムによって開かれる未来社会のことをなんと言うでしょうか？",
//         image:"../img/img-quiz04.png",
//         a:["Society5.0","CyPhy","SDGs"],
//         n:"Society5.0-科学技術政策-内閣府",
//         t:"Society5.0",
//     },
//     {
//         quizNumber:4,
//         q:"イギリスのコンピューター科学者であるギャビン・ウッド氏が提唱した、ブロックチェーン技術を活用した「次世代分散型インターネット」のことをなんと言うでしょう？",
//         image:"../img/img-quiz05.png",
//         a:["Web3.0","NFT","メタバース"],
//         t:"Web3.0",
//     },
//     {
//         quizNumber:5,
//         q:"先進テクノロジー活用企業と出遅れた企業の収益の差はどれくらいあると言われているでしょう？",
//         image:"../img/img-quiz06.png",
//         a:["約5倍","約2倍","約11倍"],
//         n:"Accenture Technology Vision 2021",
//         t:"約5倍",
//     }
// ];

// // 問題文シャッフルの関数//
// const shuffle = arrays => {
//     const array = arrays.slice();
//     for (let i = array.length - 1; i >= 0; i--) {
//       const randomIndex = Math.floor(Math.random() * (i + 1));
//     [array[i], array[randomIndex]] = [array[randomIndex], array[i]];
//     }
//     return array
// }
// const quizArray = shuffle(quizSet);

// const template=document.getElementById("js-template");

// // 問題文をHTMLに出力//
// for (let i = 0; i < quizArray.length; i++) {
// const content=template.content.cloneNode(true);
// content.querySelector(".quizIcon").textContent=`Q${i+1}`;
// content.querySelector(".quizQuiz").textContent=quizArray[i].q;
// content.querySelector(".quizPicture").src=quizArray[i].image;

// // 選択肢のシャッフル//
// const shuffledChoices = shuffle(quizArray[i].a);
// content.querySelector(".answerChoiceOne").innerHTML=shuffledChoices[0];
// content.querySelector(".answerChoiceTwo").innerHTML=shuffledChoices[1];
// content.querySelector(".answerChoiceThree").innerHTML=shuffledChoices[2];

// content.querySelector(".quizCite").textContent=quizArray[i].n;
// content.querySelector(".answerText").textContent=quizArray[i].t;
// content.querySelector(".answerTextRight").textContent=quizArray[i].t;
// document.getElementById("js-content").appendChild(content);

// createCite(i);
// };

// // 1回ボタンを押すと押せなくする//
// const setDisabled = (buttons) => {
//     buttons.forEach(button => {
//         button.disabled = true;
//     })
// }

// // それぞれの問題で正解・不正解を判定//
// const quizBlock=document.querySelectorAll(".quizOne");
// const quizTrue=document.querySelectorAll(".answerResultRight");
// const quizFalse=document.querySelectorAll(".answerResultFalse");
// quizBlock.forEach(function(num, questionNum){
//     const li=num.querySelectorAll(".button");
//         li.forEach(
//             function(r){
//                 r.addEventListener("click", () => {
//                 setDisabled(li);
//                 console.log(li)
//                 console.log(num)
//                 console.log(r.textContent);
//                 console.log(questionNum);
//                 console.log(quizArray[questionNum].t)
//                 if(r.textContent===quizArray[questionNum].t){
//                     r.classList.add('correct');
//                     quizTrue[questionNum].style.display="block";
//                 }else{
//                     r.classList.add('correct');
//                     quizFalse[questionNum].style.display="block";
//                     }
                    
//                 })        
//             }
//         );
// });

// // 資料の表示(nがあるかどうかで判断)//
// function createCite(i){
// const quizCites=document.querySelectorAll(".quizCite");
//     quizArray[i].n ? quizCites[i].style.display = "flex" : "";
// };

// }