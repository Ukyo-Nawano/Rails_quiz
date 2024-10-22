"use strict";
document.addEventListener("DOMContentLoaded", function() {
    const quizzes = document.querySelectorAll('[data-quiz-id]');

    quizzes.forEach(quiz => {
        const choices = quiz.querySelectorAll('.choice');
        const correctContainer = quiz.querySelector('.correct');
        const incorrectContainer = quiz.querySelector('.incorrect');
        const correctChoice = quiz.querySelector('.choice[data-is-valid="true"]');

        choices.forEach(choice => {
            choice.addEventListener('click', function() {
                // すでに選択されている場合は何もしない
                if (quiz.querySelector('.choice.selected')) return;

                // 正解かどうかを判断
                const isValid = choice.getAttribute('data-is-valid') === 'true';
                const correctChoiceSpan = correctContainer.querySelector('.correct_choice');
                const correctAnswerSpan = incorrectContainer.querySelector('.correct_answer');

                // すべての選択肢を非活性にする
                choices.forEach(c => {
                    c.classList.add('selected'); // すでに選択された選択肢としてマーク
                    c.style.opacity = '0.5'; // 透明度を0.5にする
                });

                // 正解・不正解の表示を制御
                correctContainer.classList.add('hidden');
                incorrectContainer.classList.add('hidden');

                if (isValid) {
                    correctContainer.classList.remove('hidden');
                    correctChoiceSpan.textContent = choice.textContent;
                } else {
                    incorrectContainer.classList.remove('hidden');
                    correctAnswerSpan.textContent = correctChoice.textContent; // 正解選択肢を表示
                }
            });
        });
    });
});
