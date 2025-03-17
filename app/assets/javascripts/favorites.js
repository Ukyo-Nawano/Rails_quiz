document.addEventListener("DOMContentLoaded", () => {
    document.body.addEventListener("click", async (event) => {
        // ボタンがクリックされたかを確認
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
        } else {
            console.error("Failed to update favorite.");
        }
    });
});
