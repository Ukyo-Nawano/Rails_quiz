document.addEventListener("DOMContentLoaded", function () {
    let questionIndex = document.querySelectorAll(".question-fields").length;
  
    // 質問の追加
    document.getElementById("add-question").addEventListener("click", function () {
      const container = document.getElementById("questions-fields");
      const newField = document.createElement("div");
      newField.classList.add("question-fields", "mb-4");
  
      newField.innerHTML = `
        <div class="mb-4">
          <input type="text" name="quiz[questions_attributes][${questionIndex}][content]" placeholder="質問内容" class="w-full p-3 border rounded-lg">
          <div class="choices-fields">
            <div class="choice-fields mb-2">
              <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][0][name]" placeholder="選択肢1" class="w-full p-3 border rounded-lg">
              <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][0][is_valid]" value="false">
              <input type="radio" name="quiz[questions_attributes][${questionIndex}][choices_attributes][0][is_valid]" value="true" class="ml-2"> 正解
            </div>
            <div class="choice-fields mb-2">
              <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][1][name]" placeholder="選択肢2" class="w-full p-3 border rounded-lg">
              <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][1][is_valid]" value="false">
              <input type="radio" name="quiz[questions_attributes][${questionIndex}][choices_attributes][1][is_valid]" value="true" class="ml-2"> 正解
            </div>
            <div class="choice-fields mb-2">
              <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][2][name]" placeholder="選択肢3" class="w-full p-3 border rounded-lg">
              <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][2][is_valid]" value="false">
              <input type="radio" name="quiz[questions_attributes][${questionIndex}][choices_attributes][2][is_valid]" value="true" class="ml-2"> 正解
            </div>
          </div>
          <textarea name="quiz[questions_attributes][${questionIndex}][supplement]" placeholder="解説を入力" class="w-full p-3 border rounded-lg mt-4" rows="3"></textarea>
          <button type="button" class="remove-question text-red-500 hover:text-red-700 mt-2">削除</button>
        </div>
      `;
  
      container.appendChild(newField);
      questionIndex++;
    });
  
    // 質問の削除
    document.getElementById("questions-fields").addEventListener("click", function (event) {
      if (event.target.classList.contains("remove-question")) {
        const questionField = event.target.closest(".question-fields");
        questionField.remove();
      }
    });
  });
  
