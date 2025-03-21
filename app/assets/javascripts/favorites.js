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

            // 現在のタブのハートマークの色を更新
            event.target.textContent = data.favorited ? "❤️" : "🤍";

            // 現在のタブのカウントを更新
            const countElement = document.getElementById(`favorite-count-${quizId}`);
            if (countElement) {
                countElement.textContent = data.favorite_count;
            }

            // 他のタブのハートマークの色とカウントを更新
            document.querySelectorAll(`[data-quiz-id="${quizId}"] .favorite-btn`).forEach(button => {
                button.textContent = data.favorited ? "❤️" : "🤍";  // ハートマークを更新
            });

            // すべてのタブに表示されているカウントを更新
            document.querySelectorAll(`[id="favorite-count-${quizId}"]`).forEach(countElement => {
                countElement.textContent = data.favorite_count;  // カウントを更新
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
                const existingCard = favoriteQuizzesContainer.querySelector(`[data-quiz-id="${quizId}"]`);
                if (!existingCard) {
                    const clonedCard = quizCard.cloneNode(true);
                    favoriteQuizzesContainer.appendChild(clonedCard);
                }
            }
        } else {
            console.error("Failed to update favorite.");
        }
    });

    // タブの切り替え処理
    const tabButtons = document.querySelectorAll(".tab-btn");
    const tabContents = document.querySelectorAll("[id$='-quizzes']");

    tabButtons.forEach(button => {
        button.addEventListener("click", (event) => {
            // タブのアクティブ状態を更新
            tabButtons.forEach(btn => btn.classList.remove("active"));
            event.target.classList.add("active");

            // タブのコンテンツ表示を更新
            const targetTabId = event.target.id === "favorites-btn" ? "favorite-quizzes" : event.target.id.replace("-btn", "");
            const targetTab = document.getElementById(targetTabId);

            if (targetTab) {
                tabContents.forEach(content => content.classList.add("hidden")); // 他のタブコンテンツを非表示に
                targetTab.classList.remove("hidden");  // 対象のタブコンテンツを表示
            } else {
                console.error(`Tab content with ID ${targetTabId} not found.`);
            }

            // タブ切り替え時に全タブ内のお気に入りボタンの色を更新
            document.querySelectorAll('.favorite-btn').forEach(button => {
                const quizId = button.dataset.quizId;
                const isFavorited = button.textContent === "❤️";
                button.textContent = isFavorited ? "❤️" : "🤍";
            });
        });
    });
});
