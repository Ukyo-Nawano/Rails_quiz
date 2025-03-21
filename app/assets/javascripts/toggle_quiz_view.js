document.addEventListener("DOMContentLoaded", () => {
    const allQuizzesTab = document.getElementById("all-quizzes");
    const favoriteQuizzesTab = document.getElementById("favorite-quizzes");
    const myQuizzesTab = document.getElementById("my-quizzes");

    const allQuizzesBtn = document.getElementById("all-quizzes-btn");
    const favoritesBtn = document.getElementById("favorites-btn");
    const myQuizzesBtn = document.getElementById("my-quizzes-btn");

    const switchTab = (tabToShow) => {
        allQuizzesTab.classList.add("hidden");
        favoriteQuizzesTab.classList.add("hidden");
        myQuizzesTab.classList.add("hidden");

        allQuizzesBtn.classList.add("bg-gray-300", "text-gray-700");
        allQuizzesBtn.classList.remove("bg-[#3DB8A4]", "text-white");

        favoritesBtn.classList.add("bg-gray-300", "text-gray-700");
        favoritesBtn.classList.remove("bg-[#3DB8A4]", "text-white");

        myQuizzesBtn.classList.add("bg-gray-300", "text-gray-700");
        myQuizzesBtn.classList.remove("bg-[#3DB8A4]", "text-white");

        tabToShow.classList.remove("hidden");

        if (tabToShow === allQuizzesTab) {
            allQuizzesBtn.classList.remove("bg-gray-300", "text-gray-700");
            allQuizzesBtn.classList.add("bg-[#3DB8A4]", "text-white");
        } else if (tabToShow === favoriteQuizzesTab) {
            favoritesBtn.classList.remove("bg-gray-300", "text-gray-700");
            favoritesBtn.classList.add("bg-[#3DB8A4]", "text-white");
        } else if (tabToShow === myQuizzesTab) {
            myQuizzesBtn.classList.remove("bg-gray-300", "text-gray-700");
            myQuizzesBtn.classList.add("bg-[#3DB8A4]", "text-white");
        }
    };

    allQuizzesBtn.addEventListener("click", () => switchTab(allQuizzesTab));
    favoritesBtn.addEventListener("click", () => switchTab(favoriteQuizzesTab));
    myQuizzesBtn.addEventListener("click", () => switchTab(myQuizzesTab));

    // 初期表示は「すべてのクイズ」
    switchTab(allQuizzesTab);

    const tabButtons = document.querySelectorAll(".tab-btn");

    tabButtons.forEach(button => {
      button.addEventListener("click", () => {
        tabButtons.forEach(btn => btn.classList.remove("active")); // すべてのタブのアクティブ状態を解除
        button.classList.add("active"); // クリックしたタブをアクティブに
      });
    });

});
