"use strict";
document.addEventListener("DOMContentLoaded", () => {
    const quizzes = document.querySelectorAll('[data-quiz-id]');

    quizzes.forEach(quiz => {
        const choices = quiz.querySelectorAll('.choice');
        const correctContainer = quiz.querySelector('.correct');
        const incorrectContainer = quiz.querySelector('.incorrect');
        const correctChoice = quiz.querySelector('.choice[data-is-valid="true"]');

        choices.forEach(choice => {
            choice.addEventListener('click', () => {
                if (quiz.querySelector('.choice.selected')) return;

                const isValid = choice.getAttribute('data-is-valid') === 'true';
                const correctChoiceSpan = correctContainer.querySelector('.correct_choice');
                const correctAnswerSpan = incorrectContainer.querySelector('.correct_answer');

                choices.forEach(c => {
                    c.classList.add('selected');
                    c.style.opacity = '0.5';
                });

                correctContainer.classList.add('hidden');
                incorrectContainer.classList.add('hidden');

                if (isValid) {
                    correctContainer.classList.remove('hidden');
                    correctChoiceSpan.textContent = choice.textContent;
                } else {
                    incorrectContainer.classList.remove('hidden');
                    correctAnswerSpan.textContent = correctChoice.textContent;
                }
            });
        });
    });
});
