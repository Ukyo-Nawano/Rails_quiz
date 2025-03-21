document.addEventListener("DOMContentLoaded", () => {
    document.body.addEventListener("click", async (event) => {
        if (!event.target.classList.contains("favorite-btn")) return;

        const quizId = event.target.dataset.quizId;
        const isFavorited = event.target.textContent === "❤️";
        const url = `/quizzes/${quizId}/favorites`;
        const method = isFavorited ? "DELETE" : "POST";

        const response = await fetch(url, {
            method: method,
            headers: {
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ quiz_id: quizId })
        });

        if (response.ok) {
            const data = await response.json();
            event.target.textContent = data.favorited ? "❤️" : "🤍";
            const countElement = document.getElementById(`favorite-count-${quizId}`);
            if (countElement) {
                countElement.textContent = data.favorite_count;
            }
            document.querySelectorAll(`#favorite-count-${quizId}`).forEach(countElement => {
                countElement.textContent = data.favorite_count;
            });

            // お気に入りタブの処理
            const favoriteQuizzesContainer = document.getElementById("favorite-quizzes");
            const quizCard = event.target.closest(".quiz-card");

            if (!data.favorited) {
                // 解除された場合、お気に入りリストから削除
                if (favoriteQuizzesContainer.contains(quizCard)) {
                    quizCard.remove();
                }
            } else {
                // 追加された場合、既にリスト内にあるか確認
                if (!favoriteQuizzesContainer.contains(quizCard)) {
                    const clonedCard = quizCard.cloneNode(true);
                    favoriteQuizzesContainer.appendChild(clonedCard);
                }
            }
        } else {
            console.error("Failed to update favorite.");
        }
    });
});
