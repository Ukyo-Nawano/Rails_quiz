document.addEventListener("DOMContentLoaded", function () {
    let questionIndex = document.querySelectorAll(".question-fields").length;

    // 質問の追加
    document.getElementById("add-question").addEventListener("click", function () {
        const container = document.getElementById("questions-fields");
        const newField = document.createElement("div");
        newField.classList.add("question-fields", "mb-4");

        newField.innerHTML = `
        <div class="mb-4">
          <input type="hidden" name="quiz[questions_attributes][${questionIndex}][id]" value="">
          <input type="text" name="quiz[questions_attributes][${questionIndex}][content]" placeholder="質問内容" class="w-full p-3 border rounded-lg">
          <div class="choices-fields">
            <div class="choice-fields mb-2">
              <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][0][name]" placeholder="選択肢1" class="w-full p-3 border rounded-lg">
              <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][0][is_valid]" value="false">
              <input type="radio" name="quiz[questions_attributes][${questionIndex}][correct_choice]" value="0" class="ml-2"> 正解
            </div>
            <div class="choice-fields mb-2">
              <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][1][name]" placeholder="選択肢2" class="w-full p-3 border rounded-lg">
              <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][1][is_valid]" value="false">
              <input type="radio" name="quiz[questions_attributes][${questionIndex}][correct_choice]" value="1" class="ml-2"> 正解
            </div>
            <div class="choice-fields mb-2">
              <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][2][name]" placeholder="選択肢3" class="w-full p-3 border rounded-lg">
              <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][2][is_valid]" value="false">
              <input type="radio" name="quiz[questions_attributes][${questionIndex}][correct_choice]" value="2" class="ml-2"> 正解
            </div>
          </div>
          <textarea name="quiz[questions_attributes][${questionIndex}][supplement]" placeholder="解説を入力" class="w-full p-3 border rounded-lg mt-4" rows="3"></textarea>
          <input type="hidden" name="quiz[questions_attributes][${questionIndex}][_destroy]" value="false">
          <button type="button" class="remove-question text-red-500 hover:text-red-700 mt-2">削除</button>
        </div>
      `;

        container.appendChild(newField);
        questionIndex++;
    });

    // 質問の削除
    document.getElementById("questions-fields").addEventListener("click", function (event) {

            const questionField = event.target.closest(".question-fields");
            
            // 確認のアラートを表示
 
                const hiddenDestroyField = questionField.querySelector('input[name*="_destroy"]');
                console.log("aaa", hiddenDestroyField);
                if (hiddenDestroyField) {
                    hiddenDestroyField.value = "true"; // 論理削除フラグをtrueに設定
                }
                
                // 各選択肢の削除フラグも設定
                const choiceFields = questionField.querySelectorAll('.choice-fields');
                choiceFields.forEach(choiceField => {
                    const hiddenChoiceDestroyField = choiceField.querySelector('input[name*="_destroy"]');
                    if (hiddenChoiceDestroyField) {
                        hiddenChoiceDestroyField.value = "true"; // 論理削除フラグをtrueに設定
                    }
                });

              questionField.remove(); // DOMから削除

      }
    );

    // 正解のラジオボタンが選択されたとき、選択肢のis_validをtrueに設定
    document.getElementById("questions-fields").addEventListener("change", function (event) {
        if (event.target.type === "radio" && event.target.name.includes("correct_choice")) {
            const questionField = event.target.closest(".question-fields");
            const allChoiceRadios = questionField.querySelectorAll("input[type='radio']");

            // すべての選択肢のis_validをfalseに設定
            allChoiceRadios.forEach(radio => {
                const hiddenInput = radio.closest('.choice-fields').querySelector('input[type="hidden"]');
                if (hiddenInput) {
                    hiddenInput.value = "false";
                }
            });

            // 正解に選ばれた選択肢のis_validをtrueに設定
            const selectedChoiceIndex = event.target.value;
            const correctChoiceField = questionField.querySelectorAll('.choice-fields')[selectedChoiceIndex];
            const hiddenInput = correctChoiceField.querySelector('input[type="hidden"]');
            if (hiddenInput) {
                hiddenInput.value = "true";
            }
        }
    });
});
