"use strict";
document.addEventListener("DOMContentLoaded", function() {
    const choices = document.querySelectorAll('.choice');

    choices.forEach(choice => {
        choice.addEventListener('click', function() {
            const isValid = choice.getAttribute('data-is-valid') === 'true';
            const quizContainer = choice.closest('[data-quiz-id]');
            const resultContainer = quizContainer.querySelector('.result');
            const correctContainer = quizContainer.querySelector('.correct');
            const incorrectContainer = quizContainer.querySelector('.incorrect');
            const correctChoiceSpan = quizContainer.querySelector('.correct_choice');
            const correctAnswerSpan = quizContainer.querySelector('.correct_answer');
            const correctChoice = quizContainer.querySelector('.choice[data-is-valid="true"]');

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
